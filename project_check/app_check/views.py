from django.shortcuts import render
from django.http import HttpResponse
from app_check import models
def index(request):
    return render(request,"show.html")

def index1(request):
    me = models.Basemessage.objects.all()[:1]
    xiangmu = models.Basemessage.objects.all()[1:2]
    hostname = models.Basemessage.objects.all()[2:3]
    system = models.Basemessage.objects.all()[3:4]
    MAC = models.Basemessage.objects.all()[4:5]
    ip = models.Basemessage.objects.all()[5:6]
    historypassword = models.Password.objects.all()[:1]
    maxpass = models.Password.objects.all()[1:2]
    minpass = models.Password.objects.all()[2:3]
    complexpass = models.Password.objects.all()[3:4]
    lengthpass = models.Password.objects.all()[4:5]
    repass = models.Password.objects.all()[5:6]
    logaudit = models.Password.objects.all()[6:7]
    syslogconf = models.Password.objects.all()[7:8]
    authlog = models.Password.objects.all()[8:9]
    ntp = models.Password.objects.all()[9:10]
    sshlog = models.Password.objects.all()[10:11]
    securelog = models.Password.objects.all()[11:12]
    processaudit = models.Password.objects.all()[12:13]
    shareaccount = models.Password.objects.all()[13:14]
    irrelevantaccount = models.Password.objects.all()[14:15]
    uid = models.Password.objects.all()[15:16]
    umask = models.Password.objects.all()[16:17]
    controlfile1 = models.Password.objects.all()[17:18]
    controlfile2 = models.Password.objects.all()[18:19]
    noowner = models.Password.objects.all()[19:20]
    return render(request, "Page_1.html", {'result': me, 'xiangmu': xiangmu, 'hostname': hostname, 'system': system, 'MAC': MAC, 'ip': ip, 'historypassword': historypassword, 'maxpass':maxpass, 'maxpass': maxpass, 'minpass': minpass, 'complexpass': complexpass, 'lengthpass': lengthpass, 'repass': repass, 'logaudit': logaudit, 'syslogconf': syslogconf, 'authlog': authlog, 'ntp': ntp, 'sshlog': sshlog, 'securelog': securelog, 'processaudit': processaudit, 'shareaccount': shareaccount, 'irrelevantaccount': irrelevantaccount, 'uid': uid, 'umask': umask, 'controlfile1': controlfile1, 'controlfile2': controlfile2, 'noowner': noowner,})
# return render(request, "Page_1.html", {'data1': data1})
# Create your views here.
