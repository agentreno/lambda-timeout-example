from time import sleep
from threading import Thread


def never_ending_method():
    while True:
        sleep(0.5)


def lambda_handler(event, context):
    t = Thread(target=never_ending_method)

    # Allow thread until one second before hard timeout
    t.start()
    timeout = (context.get_remaining_time_in_millis() - 1000) / 1000
    t.join(timeout=timeout)

    return "Detected timeout"
