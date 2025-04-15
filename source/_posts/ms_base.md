---
title: 校招-计算机基础题库
date: 2014-10-19
categories: Interview
excerpt: 包括 计算机 CS 基础/数据结构/算法/操作系统/编译原理 等方向的知识体系；也包括编程思想/设计原则/团队协作/质量意识 等软素质能力，会关注概念的基本定义与实践应用。
id: blog005
---

包括 计算机CS基础/数据结构算法/操作系统/编译原理

#### 计算机网络

<details>
  <summary>七层协议、TCP&UDP、Get&Post、IPv4&IPv6</summary>

##### OSI 的七层协议
物理层、数据链路层、网络层、传输层、会话层、表示层、应用层

##### 100baseT 表示什么？
100 表示传送速度是 100Mbit/s，Base 表示是基带传送，传送数字信号，与宽带传送对应。T 表示传输介质是双绞线，F 表示光纤

##### hub、switch、rooter 位于那一层？
冲突域：同一物理网段上所有节点的集合。<br />
广播域：接收同样广播消息的节点的集合。<br />
物理层的主要设备：中继器、集线器（hub）。不能隔离广播域和冲突域<br />
数据链路层主要设备：网桥、交换机（switch）。能隔离冲突域，不能隔离广播域

网络层主要设备：路由器（rooter）。能隔离冲突域和广播域

##### Get 和 Post 区别
Get 是不安全的，因为在传输过程，数据被放在请求的 URL 中；Post 的所有操作对用户来说都是不可见的。
Get 传送的数据量较小，这主要是因为受 URL 长度限制；Post 传送的数据量较大，一般被默认为不受限制。
Get 限制 Form 表单的数据集的值必须为 ASCII 字符；而 Post 支持整个 ISO10646 字符集。
Get 执行效率却比 Post 方法好。Get 是 form 提交的默认方法。
GET 产生一个 TCP 数据包；POST 产生两个 TCP 数据包。（非必然，客户端可灵活决定）

##### Http 请求的完全过程

浏览器根据域名解析 IP 地址（DNS），并查 DNS 缓存
浏览器与 WEB 服务器建立一个 TCP 连接
浏览器给 WEB 服务器发送一个 HTTP 请求（GET/POST）：一个 HTTP 请求报文由请求行（request line）、请求头部（headers）、空行（blank line）和请求数据（request body）4 个部分组成。
服务端响应 HTTP 响应报文，报文由状态行（status line）、相应头部（headers）、空行（blank line）和响应数据（response body）4 个部分组成。
浏览器解析渲染

##### HTTP 1.0，1.1，2.0 之间的差异
__从1.0 到 1.1__
缓存处理，在HTTP1.0中主要使用header里的If-Modified-Since,Expires来做为缓存判断的标准，HTTP1.1则引入了更多的缓存控制策略例如Entity tag，If-Unmodified-Since, If-Match, If-None-Match等更多可供选择的缓存头来控制缓存策略。

带宽优化及网络连接的使用，HTTP1.0中，存在一些浪费带宽的现象，例如客户端只是需要某个对象的一部分，而服务器却将整个对象送过来了，并且不支持断点续传功能，HTTP1.1则在请求头引入了range头域，它允许只请求资源的某个部分，即返回码是206（Partial Content），这样就方便了开发者自由的选择以便于充分利用带宽和连接。

错误通知的管理，在HTTP1.1中新增了24个错误状态响应码，如409（Conflict）表示请求的资源与资源的当前状态发生冲突；410（Gone）表示服务器上的某个资源被永久性的删除。

Host头处理，在HTTP1.0中认为每台服务器都绑定一个唯一的IP地址，因此，请求消息中的URL并没有传递主机名（hostname）。但随着虚拟主机技术的发展，在一台物理服务器上可以存在多个虚拟主机（Multi-homed Web Servers），并且它们共享一个IP地址。HTTP1.1的请求消息和响应消息都应支持Host头域，且请求消息中如果没有Host头域会报告一个错误（400 Bad Request）。

长连接，HTTP 1.1支持长连接（PersistentConnection）和请求的流水线（Pipelining）处理，在一个TCP连接上可以传送多个HTTP请求和响应，减少了建立和关闭连接的消耗和延迟，在HTTP1.1中默认开启Connection： keep-alive，一定程度上弥补了HTTP1.0每次请求都要创建连接的缺点。

降低延迟，针对HTTP高延迟的问题，SPDY优雅的采取了多路复用（multiplexing）。多路复用通过多个请求stream共享一个tcp连接的方式，解决了HOL blocking的问题，降低了延迟同时提高了带宽的利用率。

请求优先级（request prioritization）。多路复用带来一个新的问题是，在连接共享的基础之上有可能会导致关键请求被阻塞。SPDY允许给每个request设置优先级，这样重要的请求就会优先得到响应。比如浏览器加载首页，首页的html内容应该优先展示，之后才是各种静态资源文件，脚本文件等加载，这样可以保证用户能第一时间看到网页内容。

header压缩。前面提到HTTP1.x的header很多时候都是重复多余的。选择合适的压缩算法可以减小包的大小和数量。

基于HTTPS的加密协议传输，大大提高了传输数据的可靠性。

服务端推送（server push），采用了SPDY的网页，例如我的网页有一个sytle.css的请求，在客户端收到sytle.css数据的同时，服务端会将sytle.js的文件推送给客户端，当客户端再次尝试获取sytle.js时就可以直接从缓存中获取到，不用再发请求了。

__Http 2.0__

新的二进制格式（Binary Format），HTTP1.x的解析是基于文本。基于文本协议的格式解析存在天然缺陷，文本的表现形式有多样性，要做到健壮性考虑的场景必然很多，二进制则不同，只认0和1的组合。基于这种考虑HTTP2.0的协议解析决定采用二进制格式，实现方便且健壮。

多路复用（MultiPlexing），即连接共享，即每一个request都是是用作连接共享机制的。一个request对应一个id，这样一个连接上可以有多个request，每个连接的request可以随机的混杂在一起，接收方可以根据request的 id将request再归属到各自不同的服务端请求里面。

header压缩，如上文中所言，对前面提到过HTTP1.x的header带有大量信息，而且每次都要重复发送，HTTP2.0使用encoder来减少需要传输的header大小，通讯双方各自cache一份header fields表，既避免了重复header的传输，又减小了需要传输的大小。

服务端推送（server push），同SPDY一样，HTTP2.0也具有server push功能。

tcp 和 udp 区别
TCP 面向连接，UDP 是无连接的，即发送数据之前不需要建立连接。
TCP 提供可靠的服务。也就是说，通过 TCP 连接传送的数据，无差错，不丢失，不重复，且按序到达；UDP 尽最大努力交付，即不保证可靠交付。
TCP 面向字节流，实际上是 TCP 把数据看成一连串无结构的字节流，UDP 是面向报文的，UDP 没有拥塞控制，因此网络出现拥塞不会使源主机的发送速率降低（对实时应用很有用，如 IP 电话，实时视频会议等）
每一条 TCP 连接只能是点到点的，UDP 支持一对一，一对多，多对一和多对多的交互通信。
TCP 首部开销 20 字节，UDP 的首部开销小，只有 8 个字节。
TCP 的逻辑通信信道是全双工的可靠信道，UDP 则是不可靠信道。
tcp 和 udp 的优缺点

TCP
TCP 的优点：可靠，稳定。TCP 的可靠体现在 TCP 在传递数据之前，会有三次握手来建立连接，而且在数据传递时，有确认、窗口、重传、拥塞控制机制，在数据传完后，还会断开连接用来节约系统资源。
TCP 的缺点：慢，效率低，占用系统资源高，易被攻击。TCP 在传递数据之前，要先建连接，这会消耗时间，而且在数据传递时，确认机制、重传机制、拥塞控制机制等都会消耗大量的时间，而且要在每台设备上维护所有的传输连接，事实上，每个连接都会占用系统的 CPU、内存等硬件资源。 而且，因为 TCP 有确认机制、三次握手机制，这些也导致 TCP 容易被人利用，容易遭受攻击。

UDP
UDP 的优点：快，比 TCP 稍安全。UDP 没有 TCP 的握手、确认、窗口、重传、拥塞控制等机制，UDP 是一个无状态的传输协议，所以它在传递数据时非常快。没有 TCP 的这些机制，UDP 较 TCP 被攻击者利用的漏洞就要少一些。但 UDP 也是无法避免攻击的。
UDP 的缺点：不可靠，不稳定。因为 UDP 没有 TCP 那些可靠的机制，在数据传递时，如果网络质量不好，就会很容易丢包。

总结
当对数据准确性要求高的时候，应该使用 TCP，比如 HTTP、HTTPS、FTP 等传输文件的协议，POP、SMTP 等邮件传输的协议。
当对数据准确性要求不高，同时要求网络通讯速度能尽量的快的时候，这时就可以使用 UDP。比如 QQ 语音、QQ 视频。

#### Cookie 和 Session的区别理解
由于HTTP协议是无状态的协议，所以服务端需要记录用户的状态时，就需要用某种机制来识具体的用户，这个机制就是Session.

session 在服务器端，cookie 在客户端（浏览器）
session 默认被存在在服务器的一个文件里（不是内存）
session 的运行依赖 session id，而 session id 是存在 cookie 中的，也就是说，如果浏览器禁用了 cookie ，同时 session 也会失效（但是可以通过其它方式实现，比如在 url 中传递 session_id）
session 可以放在 文件、数据库、或内存中都可以。
用户验证这种场合一般会用 session

Session是在服务端保存的一个数据结构，用来跟踪用户的状态，这个数据可以保存在集群、数据库、文件中；
Cookie是客户端保存用户信息的一种机制，用来记录用户的一些信息，也是实现Session的一种方式。
</details>

<details>
  <summary>IPv4&IPv6、三次握手、外网内网</summary>
  
</details>

#### 计算机操作系统

<details>
  <summary>输入1992 返回2991 的整数翻转</summary>

```java
  public static int reverse(int x) {
        double result = 0;
        while (x != 0){
            result = result * 10 + x%10;
            if (result > Integer.MAX_VALUE) return 0;
            if (result < Integer.MIN_VALUE) return 0;
            x = x/10;
        }
        return (int) result;
    }
```
  
</details>