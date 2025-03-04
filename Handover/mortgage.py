#!/usr/bin/env python3

principal = 1065000
payment = 34157
rate = 0.11
total_paid = 0

extra = 10000
extra_s = 1
extra_e = 10
month = 0

out = open('schedule.txt', 'w')
print('{:>5s} {:>8s} {:>12s} {:>10s} {:>10s}'.format('Month', 'EMI', 'Interest', 'Principal', 'Total_Paid'), file=out)
while principal > 0:
    month += 1
    if month >= extra_s and month <= extra_e:
        total_payment = payment + extra
    else:
        total_payment = payment
    interest = principal * (rate/12)
    principal = principal + interest - total_payment
    total_paid += total_payment
#print('month={},total_paid={}'.format(month,total_paid))

    #print(month, total_payment, interest, principal,total_paid)
    #print('%10s %10d %10.2f' % ('text', total_payment, interest)
    print('{:>5d} {:>10d} {:>10.2f} {:>10.2f} {:>10.2f}'.format(month, total_payment, interest, principal,total_paid),file=out)

out.close()



'''
p = 1056000
e = 34156
r = 0.11
t = 0
m = 0 

x = 1000
x_s = 3
x_e = 6

out = open("testx.txt", "w")
print("{:>5s} {:>10s} {:>10s} {:>10s}".format("Month", "Interest", "Principal", "Total"), file=out)
while p > 0:
    m += 1
    if m >=3 and m <= 6:
        e += x

    i = p * (r/12)
    p = p + i - t
    t += e
    print('{:>5d} {:>10.2f} {:>10.2f} {:>10d}'.format(m,i,p,t), file=out)
out.close()

'''
