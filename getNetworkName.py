#!/usr/bin/env python3
import subprocess


def run(cmd):
    w = subprocess.check_output(["/bin/bash", "-c", cmd])
    return w

cur = str(run("nmcli -t -f NAME connection show --active"))
cur = cur[2:][:-3]
cur = cur.split("\\n")
alw = str(run("nmcli -t -f active,ssid dev wifi"))#.split("\n")
alw = alw.replace("\\xd0\\xbd\\xd0\\xb5\\xd1\\x82:", '')
alw = alw.replace("\\xd0\\xb4\\xd0\\xb0:", '')
alw = alw[2:][:-3]
alw = alw.split("\\n")

for i in alw:
    if ':' in i:
        i = i[i.index(':'):]

#print(alw)
#print(cur)

y = 0
for i in cur:
    if i in alw:
        print("W: " + i)
        y = 1
        break

if y == 0 and len(cur) > 0:
    print("N: " + cur[0])
