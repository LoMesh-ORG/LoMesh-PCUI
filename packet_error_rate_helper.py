import stopit
import serial
import re
import time

def ping_test(target, timeoutval, ser):
    ser.reset_input_buffer()
    ser.write(b'AT+SEND:' + target.encode('utf-8') + b'=ping\r\n')
    responcestr = ser.read_until().decode('utf-8')
    if("NOT OK" in responcestr):
        print("Error in sending message")
        return -1
    print("Sent message id", responcestr)
    msg_id = re.search('%s(.*)%s' % (":", "\r"), responcestr).group(1)
    looking_for = b'ACK:' + msg_id.encode('utf-8')
    print("Looking for", looking_for)
    print("Sent message id ", int(msg_id, 10))
    return_code = -1
    #Now loop here till you hear back ACK for the message
    with stopit.ThreadingTimeout(timeoutval) as to_ctx_mgr:
        assert to_ctx_mgr.state == to_ctx_mgr.EXECUTING
        while(1):
            ser.write(b'AT+RECV\r\n')
            responcestr = ser.read_until()
            print(responcestr, responcestr.find(looking_for))
            if(responcestr.find(looking_for) >= 0):
                #found the message id we were looking for
                print("Found ACK")
                return_code = 0
                to_ctx_mgr.state == to_ctx_mgr.EXECUTED
                break
            time.sleep(0.25)
    # OK, let's check what happened
    if to_ctx_mgr.state == to_ctx_mgr.EXECUTED:
        # All's fine, everything was executed within 10 seconds
        print("Got ACK") 
    elif to_ctx_mgr.state == to_ctx_mgr.EXECUTING:
        # Hmm, that's not possible outside the block
        pass
    elif to_ctx_mgr.state == to_ctx_mgr.TIMED_OUT:
        # Eeek the 10 seconds timeout occurred while executing the block
        print("Timed out")
    elif to_ctx_mgr.state == to_ctx_mgr.INTERRUPTED:
        # Oh you raised specifically the TimeoutException in the block
        pass
    elif to_ctx_mgr.state == to_ctx_mgr.CANCELED:
        # Oh you called to_ctx_mgr.cancel() method within the block but it
        # executed till the end
        pass
    else:
        # That's not possible
        pass
            
    return return_code