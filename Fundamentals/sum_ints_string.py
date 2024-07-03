# https://www.codewars.com/kata/598f76a44f613e0e0b000026/python

import re

def sum_of_integers_in_string(s):
    return sum(int(x) for x in re.findall(r"(\d+)", s))

def sum_of_integers_in_string(s):
    return sum(list(map(int, re.findall('\d+',s))))

print(sum_of_integers_in_string("The30quick20brown10f0x1203jumps914ov3r1349the102l4zy dog")) # 3635