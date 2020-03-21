
from datetime import datetime

now = datetime.now()
 
# print("now =", now)
# # dd/mm/YY H:M:S
# dt_string = now.strftime("%d/%m/%Y %H:%M:%S")
# print("date and time =", dt_string)

dt_string = now.strftime("%Y%m%d%H%M")
print("date and time =", dt_string)
