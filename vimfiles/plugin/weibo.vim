function! s:CmdLine_weibo(initstr, inreplyto)
    call inputsave()
    redraw
    let mesg = input("say something:", a:initstr)
    call inputrestore()
    " call s:post_twitter(mesg, a:inreplyto)
    
    echo 'sending...'

python << EOF

import vim
import urllib2, base64
from urllib import urlencode
import sys

URL = 'http://api.weiboto.com/statuses/update.json?source="dudu"'
KEY = 'xuedudu@gmail.com'
PASSWORD = 'weibotoxue123'
msg = vim.eval("mesg")

if len(msg) < 2 :
    print 'what to say?'
else:
    #msg = unicode(msg, 'gb2312','ignore').encode('utf-8','ignore')
    request = urllib2.Request(URL)
    base64string = base64.encodestring('%s:%s' % (KEY, PASSWORD)).replace('\n', '')
    request.add_header("Authorization", "Basic %s" % base64string)   
    postdata = urlencode([('status', msg), ('weibo_type_list', 'SINA,TWITTER,DOUBAN,TENCENT')])
    request.add_data(postdata)
    result = urllib2.urlopen(request)
    print result.read()

    
EOF

endfunction


command PostWeibo :call <SID>CmdLine_weibo('', 0)

