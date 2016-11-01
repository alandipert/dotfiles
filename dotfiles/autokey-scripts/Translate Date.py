from datetime import datetime, timedelta
import re

ret, s = dialog.input_dialog("Enter Time", "Enter a PST hour")
if ":" not in s:
  r = re.search("([1-9]+)(.*)", s)
  s = r.group(1) + ":00" + r.group(2)
p = datetime.strptime(s.replace(" ", "").upper(), "%I:%M%p")
e = p + timedelta(hours=3)

def fmt(d, tz):
  return d.strftime("%-I:%M %p ") + tz

def formatDates(t1, t2):
  return fmt(t1, "EDT") + "/" + fmt(t2, "PDT")

keyboard.send_keys(formatDates(e, p))
