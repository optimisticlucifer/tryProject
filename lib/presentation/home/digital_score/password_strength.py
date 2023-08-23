import re
import string

def passwordStrength(password):
    try:
        arr = [["0", "0","0","0","0","0","0","2 secs","25 secs", "4 min", "41 min", "6 hours", "2 days", "4 weeks", "9 months"],
                ['0',  '0',  '0',  '0',  '5 secs',  '2 min',  '58 min',  '1 day',  '3 weeks',  '1 year',  '51 years',  '1k years',  '34k years',  '800k years',  '23 million years'],
                ['0',  '0',  '0',  '25 secs',  '22 min',  '19 hours',  '1 month',  '5 years',  '300 years',  '16k years',  '800k years',  '43 million years',  '2 billion years',  '100 billion years',  '6 trillion years'],
                ['0',  '0',  '1 secs',  '1 min',  '1 hour',  '3 days',  '7 months',  '41 years',  '2k years',  '100k years',  '9 million years',  '600 million years',  '37 billion years',"2 trillion years'",  '100 trillion years'],
                ['0',  '0',  '5 secs',  '6 min',  '8 hours',  '3 weeks',  '5 years',  '400 years',  '34k years',  '2 million years',  '200 million years',  '15 billion years',  '1 trillion years',  '93 trillion years',  '7 quadrillion years']]

        Len = len(password)

        Type = 0

        patterns = [
            re.compile(r"[0-9]+"), re.compile(r"[a-z]+"), re.compile(r"[A-Za-z]+"), re.compile(r"[A-Za-z0-9]+"),
            re.compile(r"(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[#$@!%&*?])[A-Za-z\d#$@!%&*?]{6,30}")
        ]

        # re.fullmatch(low, "we3rt")
        time = ""
        x = 0
        for j in range(len(patterns)):
            if(re.fullmatch(patterns[j], password)):
                time = arr[j][Len-4]
                print("j",j,Len-4)
                x = j
                break
        score1 = 5
        if("million" in time or "millions" in time):
            score1 = 5
        elif("year" in time or "years" in time):
            score1 = 4
        elif(("day" in time) or ("weeks" in time) or ("week" in time) or 
                ("days" in time) or "months" in time or ("month" in time)):
                score1 = 3
        elif(("min" in time) or ("mins" in time) or ("hours" in time) or ("hour" in time) or 
                ("sec" in time) or ("secs" in time)):
                score1= 1
        score = 0

        if any(c.isupper() for c in password):
            score += 0.5
        if any(c.islower() for c in password):
            score += 0.5
        if any(c.isdigit() for c in password):
            score += 0.5
        if any(c in string.punctuation for c in password):
            score += 1
        if len(password) >= 8:
            score += 0.5
        if len(password) >= 12:
            score += 0.5
        if len(password) >= 16:
            score += 0.5
        if len(password) >= 20:
            score += 1
        

    except Exception as e:
        responseBody = {
            "message": f"Unknown error {e.__str__()} ",
            "status": "error"
        }
        response = {
            "statusCode": 503,
            "body": json.dumps(responseBody)
        }
        return 0
    else:
        print(score+score1,"",time)
        return {
            "Score":score+score1,
            "time":time
        }
    
passwordStrength("Test@123")
