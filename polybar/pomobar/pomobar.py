#!/usr/bin/python3
# -*- coding: UTF-8 -*-
##############################################################################
# ORIGINAL AUTHOR: [Loopzen](https://github.com/loopzen/)
# DATE: 2018-10-09
# MODIFICATION : [Solarius] 2021
# DESCRIPTION: Pomodoro timer to polybar
# - Counter of all your completed pomodoros
# - Desktop notifications
# REQUERIMENTS:
# - polybar
##############################################################################
import argparse
import configparser
import os
import sqlite3
import time
from os.path import expanduser

# GLOBAL CONSTANTS
HOME_FOLDER = expanduser("~/")
MINUTE = 60

# DEFAULT CONFIGS
ICON_TOTAL = "⨀  "
DATABASE_PATH = HOME_FOLDER + "pomobar.db"


# CUSTOM CONFIGS
config = configparser.ConfigParser()
config.read(HOME_FOLDER + ".config/polybar/pomobar/pomobar.conf")
if config.has_option("DEFAULT", "ICON_TOTAL"):
    ICON_TOTAL = config["DEFAULT"]["ICON_TOTAL"] + " "
if config.has_option("PATH", "DATABASE_PATH"):
    DATABASE_PATH = config["PATH"]["DATABASE_PATH"]


class Pomodoro:
    """Normal pomodoro"""

    def __init__(self, duration=25):
        self.duration = int(duration)
        self.ICON = "⨁  "

    def start(self):
        while self.duration > 0:
            writeOutput("%{F#bf616a}" + self.ICON + str(self.duration) + "%{F-}")
            recharge_polybar()
            time.sleep(MINUTE)
            self.duration -= 1

        if self.duration <= 0:
            GlobalPomodoroCounter.increment_global_pomodoro_counter()
            writeOutput(ICON_TOTAL + GlobalPomodoroCounter.get_pomodoros_done())
            recharge_polybar()
            os.system("notify-send --urgency=normal Pomodoro finished")
            os.system("paplay /usr/share/sounds/sound-icons/beginning-of-line")
            temp = int(GlobalPomodoroCounter.get_pomodoros_done())
            if temp % 4 == 0:
                auto_break_time = Break(15)
            else:
                auto_break_time = Break()
            auto_break_time.start()


class Break:
    """Break time class"""

    def __init__(self, duration=5):
        super().__init__()
        self.duration = int(duration)
        self.ICON = "⨂  "

    def start(self):
        while self.duration > 0:
            writeOutput("%{F#a3be8c}" + self.ICON + str(self.duration) + "%{F-}")
            recharge_polybar()
            time.sleep(MINUTE)
            self.duration -= 1

        if self.duration <= 0:
            writeOutput(ICON_TOTAL + GlobalPomodoroCounter.get_pomodoros_done())
            recharge_polybar()
            os.system("notify-send Break finished")
            os.system("paplay /usr/share/sounds/sound-icons/beginning-of-line")


class GlobalPomodoroCounter:
    """Leer y registrar el contador total de pomodoros realizados"""

    @staticmethod
    def create_table():
        try:
            connection = sqlite3.connect(DATABASE_PATH)
            cursor = connection.cursor()
            cursor.execute(
                """
                    CREATE TABLE POMODOROS (
                        COMPLETADOS TEXT
                    )
                    """
            )
            cursor.execute("INSERT INTO POMODOROS VALUES ('0')")
            connection.commit()
            connection.close()
        except Exception as e:
            if "exists" in str(e):
                pass
            else:
                print(e)

    @staticmethod
    def increment_global_pomodoro_counter():
        pomodoros_completados = GlobalPomodoroCounter.get_pomodoros_done()
        pomodoros_actualizados = str(int(pomodoros_completados) + 1)
        try:
            connection = sqlite3.connect(DATABASE_PATH)
            cursor = connection.cursor()
            cursor.execute(
                "UPDATE POMODOROS SET COMPLETADOS = ("
                "" + pomodoros_actualizados + ""
                ") WHERE COMPLETADOS = '" + pomodoros_completados + "'"
            )
            connection.commit()
            connection.close()
        except Exception as e:
            print(e)
        return pomodoros_completados

    @staticmethod
    def get_pomodoros_done():
        pomodoros_completados = "0"
        try:
            connection = sqlite3.connect(DATABASE_PATH)
            cursor = connection.cursor()
            cursor.execute("SELECT COMPLETADOS FROM POMODOROS")
            pomodoros_completados = cursor.fetchone()[0]
            connection.close()
        except Exception as e:
            print(e)
        return pomodoros_completados


##############################
# AUXILIAR FUNCTIONS
##############################


def kill_another_instances():
    """Kill another instances to avoid collisions"""
    os.system("pgrep pomobar > pomobar.pid")
    filePids = open("pomobar.pid", "r")
    for pid in filePids:
        pid = int(pid)
        if pid != int(os.getpid()):
            os.system("kill -9 " + str(pid))
    filePids.close()
    os.system("rm pomobar.pid")


def getArguments():
    """Handle input parameters"""
    parser = argparse.ArgumentParser(
        prog="POMOBAR",
        description="Pomodoro implementation to polybar and terminal",
        formatter_class=argparse.RawDescriptionHelpFormatter,
    )
    parser.add_argument(
        "-a",
        "--action",
        type=str,
        default="new",
        help="What action? (new, break, kill)",
    )
    parser.add_argument("-d", "--duration", type=str, help="Pomodoro duration")
    args = parser.parse_args()
    return args


def dispatcher(args):
    """Dispatcher to serveral actions"""
    if args.action == "new":
        if args.duration is None:
            pomodoro = Pomodoro()
        else:
            pomodoro = Pomodoro(args.duration)
        GlobalPomodoroCounter.create_table()
        pomodoro.start()
    elif args.action == "break":
        if args.duration is None:
            break_time = Break()
        else:
            break_time = Break(args.duration)
        break_time.start()
    elif args.action == "kill":
        stop()
    elif args.action == "reset":
        reset()


def writeOutput(message):
    """Write message to output file and console"""
    try:
        print(message)
        fileOutput = open(HOME_FOLDER + ".pomobaroutput", "w")
        fileOutput.write(message)
        fileOutput.close()
    except Exception as e:
        print(e)


def stop():
    """Stop stopwatch"""
    writeOutput(ICON_TOTAL + GlobalPomodoroCounter.get_pomodoros_done())
    recharge_polybar()
    os.system("notify-send --urgency=low Pomodoro cancelado")


def reset():
    """Delete database to reset pomodoro count"""
    os.remove(DATABASE_PATH)
    writeOutput(ICON_TOTAL + GlobalPomodoroCounter.get_pomodoros_done())
    recharge_polybar()
    os.system("notify-send --urgency=low Pomodoro reset count")


def recharge_polybar():
    """Command to restart polybar"""
    os.system("polybar-msg hook pomobar 1 &> /dev/null")


def main():
    """Start programm"""
    kill_another_instances()
    args = getArguments()
    dispatcher(args)


if __name__ == "__main__":
    main()
