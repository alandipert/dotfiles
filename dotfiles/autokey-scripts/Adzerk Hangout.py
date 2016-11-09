ret, s = dialog.input_dialog("New Hangout", "Enter a name for your Hangout")
url = "https://plus.google.com/hangouts/_/adzerk.com/{0}".format(s)
keyboard.send_keys(url)