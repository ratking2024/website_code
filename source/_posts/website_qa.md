---
title: 网站建设与部署问题记录
date: 2015-05-15
categories: Website
id: blog001
---
### 前言

本文档旨在记录个人站点建设过程中遭遇的挑战及其解决方案，着重概述主要架构和操作流程，而非详尽地逐步说明具体操作细节。

### 网站基础

#### 第三方域名

关于快速建设一个可托管的个人网站目前业界有一些流行方案可选

1. GitHub Pages: GitHub 提供的一项服务，允许用户免费托管静态网站。它特别适合个人、项目或组织的博客、项目文档和个人简历等网站。
2. Netlify: 提供免费的静态网站托管服务，支持自动从 Git 仓库部署，并提供自定义域名、HTTPS、全球 CDN 等功能。
3. Vercel: 类似于 Netlify，Vercel 也提供从 Git 仓库自动部署的静态网站托管服务，支持 Serverless 函数和全球 CDN。
4. GitLab Pages: 类似于 GitHub Pages，GitLab Pages 允许你使用 GitLab 仓库托管静态网站，并提供自定义域名和HTTPS支持。
5. Firebase Hosting: Google 提供的托管解决方案，适合托管静态内容，如 HTML、CSS、JavaScript 和图片，支持自定义域名和HTTPS。
6. Cloudflare Pages: 提供静态网站托管服务，免费提供无限次的网站构建，支持自定义域名和HTTPS。
7. Amazon S3 + Amazon CloudFront: 使用 Amazon S3 存储静态网站内容，并通过 Amazon CloudFront 提供 CDN 服务。需要配置，可能涉及费用。

因 Github Pages 操作相对简单，以此方案推进。 操作方式为以固定格式 <sup>仓库名称：xxx.github.io</sup> 创建一个仓库，并上传 index.html 文件。 之后可通过该域名访问可看到一个静态网页。

#### 个人域名dns解析

当已经获得了 `yourname.github.io` 这样一个 Github Pages 网页后，觉得这个网址不够 cool，需要有一个自己的个人域名 `www.yourname.com` 此时需要用到域名解析服务。

目前国内推荐的云服务平台是 阿里云 或 腾讯云 ，这里以腾讯云举例 [腾讯云域名购买页](https://dnspod.cloud.tencent.com/) 一般 .com .cn .net 等可选，价格为几百元/年。 付款后可以去 [腾讯云控制台入口](https://console.cloud.tencent.com/domain)、[腾讯云 dns 控制台](https://console.cloud.tencent.com/cns) 进行对应的操作与配置。 

同时，因为购买的域名需要重定向到源域名，源域名一般会对随意的重定向有限制，因此需要再 Github Pages 里的设置里 custome domain 填写购买与注册的新域名。

#### 接入cdn

计算机专业的都知道 cdn 是就近节点缓存了资源文件，使得重复访问速度可以更快。 这个服务在腾讯云里也可以付费购买。 [腾讯云 cdn 控制台](https://console.cloud.tencent.com/cdn) 这里需要判断是境内加速还是境外加速，Github Pages 属于境外。 在大多数网络环境 Github 域名是可以访问的，若需要域名能在境内高速访问需要备案并购买境内云主机用于部署。

当源网站内容进行更新后，会在一定延迟内同步到 cdn ，若需要立刻生效则使用 cdn 中的 url 刷新功能。与之平级的还有 url 预热，预热的区别是提前在各节点缓存该域名的资源文件，使得用户的第一次访问也可以加速，默认的 cdn 是首次访问后第二次开始才能加速。

#### 接入https

##### 问题：地址栏提示感叹号或不安全

浏览器的地址栏里填写个人域名的网址，该网址前面可能会出现一个 感叹号，或标红此网站不安全，这就是此网站没有接入 https。

这时需要购买 SSL证书 [腾讯云 ssl 控制台](https://console.cloud.tencent.com/ssl)，也可以选择免费的，免费局限性在于时效较短需要频繁更新，并且安全级别较低真出现了信息隐患平台也不承担责任。

##### 问题：网页错误响应码 514

需要确认 cdn 域名管理/HTTPS配置/HTTPS服务 是勾选的。 这里是请求量 300万次内免费，超过付费。 若不勾选则不会产生费用，但会报 514 错误，一般可能是欠费导致此处关闭了，但其他某链路却设置了 HTTPS。

##### 问题：报错 ERR_TOO_MANY_REDIRECTS

这个报错看上去很像是个人域名与源域名有循环跳转的情况。所以需要确认 dns 中的 @ CNAME 指向了 cdn 的域名。 并且 cdn 域名管理/基础设置/回源地址是源地址，回源 Host 是新域名。

同时也需要确认 是否均开启了 HTTPS，因为有的重定向规则 HTTP 重定向到HTTPS，同时又将 HTTPS 重定向回 HTTP。 所以需要确认 Github Pages 设置里勾选了 `Enforce HTTPS` ，cdn 域名管理/基础设置/回源协议是 HTTPS。

### 网站样式

考虑到博客与文档会使用更适合文档编写的 md 格式，所以需要一个能够将 md 格式文档转换成 html 产物的站点生成器。

#### 站点生成器

1. Hexo: 简单且强大的基于 Node.js 的静态站点生成器，特别适合用于个人博客的构建。支持 md 文件转换为 HTML，并且拥有丰富的插件系统和主题生态。
2. Jekyll: Ruby 编写的静态站点生成器，与 GitHub Pages 集成非常紧密，支持 md 和 Liquid 模板。
3. Hugo: 使用 Go 语言编写的静态站点生成器，以其构建速度快而闻名，支持 md 和自定义模板。
4. Gatsby: 基于 React 的现代静态网站生成器，使用 GraphQL 管理数据，支持 md。
5. VuePress: 由 Vue.js 驱动的静态站点生成器，专为技术文档而设计，支持 md。

考虑到使用方便以及行业生态，这里使用 Hexo 来作为方案推进。 在一个空文件夹使用 `Hexo init` 指令来开启项目。 接下来将会经常频繁的用到如下指令
```
hexo clean  # 清除生成的 html 产物
hexo generate # 重新生成
hexo server # 本地预览
hexo deploy # 远端发布
```
使用 generate 指令后会产生 .deploy_git 文件，可在此文件目录修改 git config 等信息避免 commit 上 author 错误。

#### 网站主题选择

Hexo 官方提供了非常友好的主题展示与预览 [HexoThemes](https://hexo.io/themes/)。看上了哪个基本都可以使用如下指令安装，考虑后选用 Next 主题。 该主题的优势为兼容性好，界面风格简单不花哨。
```shell
npm install hexo-theme-next
```

Hexo 有一个配置文件 根目录 / _config.yml 文件 <sup>用于站点基础类信息配置</sup>
下载了 Next 主题后，主题的配置文件在 根目录 / themes / next / _config.yml 文件 <sup>用于站点主题样式类配置</sup> 例如：想修改站点名称 应是前一个，想修改代码块高亮的方式 应是后一个。

Next 的配置文件中的配置项是 Next 定义的，配置项随着版本更新也会有变化，若出现一些属性设置不生效时，可以使用自定义 css 样式。 自定义 css 样式一般创建在 根目录 / source / css / _custom / custom.styl 。

通过 Hexo 配置文件中的配置 <sup>如下</sup> 将 Hexo 和 Next 关联

```yaml
theme: next
```

通过 Next 配置文件中的配置 <sup>如下</sup> 将 Next 主题与自定义样式关联  

```yaml
custom_file_path:
    style: source/css/_custom/custom.styl
```

#### 主题内对应设置

一般来说样式都可以在配置文件与 custome.styl 文件中找到答案，在网站中的 icon 可以在 [google icon 大全](https://fonts.google.com/icons) 、[fontawesome icon 大全](https://fontawesome.com/v5/search?o=r&m=free) 寻找。
对于字体的配置可以在 [google 字体大全](https://fonts.google.com/) 里寻找。

##### 问题：设置自定义首页

这个问题也可以理解为域名直接访问的首页，并不是我在 / home / 下定义的首页。 因为 Hexo 的首页默认生成一些文章列表摆在这，这让你的首页一进入是并不清爽。

解决的办法是：先将 / home / 下的自定义首页移到 source 的根目录，然后通过 Hexo 的配置文件禁用自动生成，这样本身根目录下的 index.md 生成的html 就不会被冲掉了。

```yaml
index_generator:
  path: ' '  # 中间有个空的空格
```

同时 Next 配置文件的 home 也指向根目录，这样即可做到 __通过域名访问的首页，和点击 home 按钮返回的首页是一个页面__。

```yaml
menu:
  home: / || fa fa-igloo
  about: /about/ || fa fa-user-graduate
  tags: /tags/ || fa fa-tag
  categories: /categories/ || fa fa-th-list
  archives: /archives/ || fa fa-book
  sitemap: /sitemap.xml || fa fa-sitemap
```

##### 问题：设置中文与英文为不同的字体样式


### 数学公式渲染

文章是使用 md 格式的，md 可以通过渲染器实现数学公式这样非常「书面」的显示，类似这样的效果：

$$
J_\alpha(x) = \sum_{m=0}^\infty \frac{(-1)^m}{m! \Gamma (m + \alpha + 1)} {\left({ \frac{x}{2} }\right)}^{2m + \alpha}
$$

这里需要先编写并生成中间产物，然后再将中间产物渲染出来。

#### 数学语法编写

需要安装处理数学公式的插件，这一步动作的目的是 md 中使用的数学公式语法在 `hexo generate` 时会生成对应的 html 标签。

在终端执行
```shell
npm install hexo-math --save
```
修改 hexo 根目录 `_config.yml`
```yaml
math:
  engine: 'mathjax' # 或者 'katex'，取决于你想使用哪个渲染器
  mathjax:
    src: https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.7/MathJax.js?config=TeX-MML-AM_CHTML
    config:
      # MathJax 配置项
```
然后就是 md 中的编写了，具体语法可参考 [链接] ，不同语法在 hexo 主题中的显示效果可见我的另一篇博文 [链接]。

#### 渲染器

当你在本地使用 Hexo 生成站点时，你可以使用 Pandoc 作为 md 渲染器，但是最终生成的静态 HTML 文件应该包含了渲染后的数学公式代码。如果你希望在本地使用 Pandoc 来渲染数学公式，你需要在本地环境中安装 Pandoc

下载 `hexo-renderer-pandoc` 插件前也先要让电脑里安装了 pandoc
```shell
brew install pandoc
npm install hexo-renderer-pandoc --save
```

GitHub Pages 并不支持服务器端的渲染器，如 Pandoc。因此你不能直接控制 GitHub Pages 使用 Pandoc 来渲染你的数学公式。GitHub Pages 只能托管静态内容，所以你需要在本地生成所有静态文件，然后上传到 GitHub。

即使是使用 Pandoc 渲染的数学公式，最终在 GitHub Pages 上的显示也依赖于客户端的 JavaScript 库 <sup>如 MathJax 或 KaTeX</sup> 来正确显示数学公式。

将生成的 html 标签渲染成对应数学公式，需要使用渲染器插件，在 Next 主题的官方文档中就提到 katex 可能有未知问题，建议使用 pandoc。

修改 hexo 根目录 `_config.yml`
```yaml
pandoc:
  filters:
    - pandoc-citeproc
  extra:
    - --mathjax
  meta:
    - my-meta-data
```
修改 Next 的 `_config.yml`
```yaml
mathjax:
    enable: true
```
这样可以做到渲染器在本地生效，并且在远端网页也生效。

### 站内搜索

#### Algolia注册

在 https://www.algolia.com/ 官网点击右上角的注册，可直接使用 `google` 账号或 `github` 账号一键关联登入，登入后在 https://dashboard.algolia.com/ 控制台查看。
在控制台内需要创建一个 indexname 作为一个标识，之后在本地配置时会用到，其他的配置可以都忽略。免费账户总共有 10,000 条记录，每月有 100,000 的可以操作数。

#### Algolia接入

在终端使用如下指令拉取 hexo 插件依赖

```shell
npm install --save hexo-algolia
```

可以通过如下指令查看已安装的插件版本

```shell
npm list --depth=0 | grep hexo-algolia
```

#### 基础搜索功能

例如我使用 hexo 的 Next 主题，需在 themes/next/_config.yml 文件中增加

```yml
algolia_search:
  enable: true # 主要也就是把这里从 false 改为 true
  hits:
    per_page: 10
  labels:
    input_placeholder: Search for Posts
    hits_empty: "We didn't find any results for the search: ${query}"
    hits_stats: "${hits} results found in ${time} ms"
```

并在 hexo 根目录的 _config.yml 中增加

```yml
algolia:
  appId: '你的ApplicationID'
  apiKey: '你的AdminAPIKey' 
  indexName: '你的IndexName'
```

并在本机器的 `~/.zshrc` 中增加下面一行环境变量，并执行 `source ~/.zshrc`。

```js
export HEXO_ALGOLIA_INDEXING_KEY='你的AdminAPIKey'
```

若填写不正确，会看到如下报错
```ruby
ERROR [hexo-algolia] Please provide an Algolia index name in your hexo _config.yml file.
ERROR >> Read https://npmjs.com/hexo-algolia#public-facing-search-options for more informations.

ERROR [hexo-algolia] Please set an `HEXO_ALGOLIA_INDEXING_KEY` environment variable to enable content indexing.
ERROR >> Read https://npmjs.com/hexo-algolia#api-key for more informations.
```

配置完毕后再终端需要一键四连了，或弄个脚本简化
```
hexo clean
hexo generate
hexo algolia
hexo deploy
```
其中 `hexo algolia` 指令是需要在 `hexo generate` 之后执行的，因前者生成了 html 文件，后者是从这里提取所需索引字段并对 indexname 和 appid 去上传。执行后在 Algolia 的控制台内可看到上传的信息。
一般来说每次文章内容更新后都应当使用此指令更新索引。

#### 支持content搜索

使用上述方式配置之后，网站内可以基于 title 搜索了，但这是不够的。 期望的状态是：__每篇文章的内容也可以搜索，输入了内容的关键字也可以搜到对应的文章标题__ 

按照官方文档的介绍是在 hexo 跟目录下的 `_config.yml` 文件中增加如下配置，其中`content`为内容部分

```yaml
algolia:
  appId: '你的ApplicationID'
  apiKey: '你的AdminAPIKey'
  indexName: '你的IndexName'
  fields:
    - title
    - content
    - date
    - tags
    - categories
```

`title`、`tags` 等字段基于 md 文章的 header 部分提取。 `content` 字段 Hexo Algolia 插件在索引时会查找并提取这个 `articleBody` 区域的内容。并不需要添加任何特殊的 content 标记，插件会自动处理这部分。 默认情况下文章的内容被放置在具有 `post-body` 类的 `div` 标签内，并且使用了 `itemprop="articleBody"` 属性。这是 Hexo 生成的 HTML 结构。

但我配置后并没有生效，在 Algolia 的控制台内接收到的索引 item 信息里别的都有就是没有 `content` 。经过验证是 `_config.yml` 中的 `fields` 属性并没有生效，所以想增加 `content` 的诉求还是被忽略了，经过一番换写法的尝试该属性还是不生效。

##### 问题：config 文件 algolia fields 不生效

解决方案是修改源码。通过 `npm install --save hexo-algolia` 下载插件一版都位于hexo根目录下的 `node_modules` 文件夹内，原逻辑是源码中设置了默认的索引上传字段，然后基于配置文件可以修改这些上传字段，在 `hexo-alogia/lib/command.js` 的变量位置增加了 `content` 字段后 It works。

```js
var CONSOLE_DEFAULTS = {
  dryRun: false,
  flush: false,
  chunkSize: 50,
  layouts: INDEXED_LAYOUTS
};

var INDEXED_PROPERTIES = [
  'title',
  'content', //这里是新增的
  'date',
  'updated',
  'slug',
  'excerpt',
  'permalink',
  'layout',
  'image'
];

```

虽然 It works 但终端仍然有报错信息 

##### 问题：[hexo-algolia] ERROR objectID is too big size

```ruby
ERROR [hexo-algolia] Record at the position 2 objectID=xx is too big size=10677/10000 bytes. 
Please have a look at https://www.algolia.com/doc/guides/sending-and-managing-data/prepare-your-data/in-depth/index-and-records-size-and-usage-limitations/#record-size-limits
```
我这篇文章其实并不长，但居然报了说 too big，因为我们是使用 hexo 框架对一个 md 文件去生成的 html 文件，这里有大量的 <标签> 充斥在正文内，很快会把 10KB 撑满，__至此也终于理解了为什么 hexo-algolia 的作者会在默认值中不带上 content 了，因为一带上大部分用户都会遇到 too big 报错，所以干脆去掉了 content__。

对于这个问题的解决办法是 在插件内拼接好`content`准备向 Algolia 发请求时，将这里的大量标签信息过滤一下。 目标是 __只保留汉字信息与英文单词信息，过滤掉<>标签信息以及一些常见的标签英文单词__ 代码如下

```js
function extractText(text) {
  // 移除 HTML 标签
  text = text.replace(/<[^>]*>/g, '');
  // 定义要移除的 HTML 标签单词列表
  const removeWords = ['p', 'id', 'body', 'div', 'span', 'class', 'style'];
  // 构建移除这些单词的正则表达式
  const removeWordsRegex = new RegExp('\\b(' + removeWords.join('|') + ')\\b', 'gi');
  // 移除常见的 HTML 标签单词
  text = text.replace(removeWordsRegex, '');
  // 匹配中文字符和英文单词的正则表达式
  const extractRegex = /[\u4e00-\u9fa5a-zA-Z]+/g;
  // 提取中文字符和英文单词，并连接成一个字符串
  const extractedText = (text.match(extractRegex) || []).join(' ');
  return extractedText;
}
```

然后将这个正则过滤的代码放到对应位置

```js
.then(function(publishedPagesAndPosts) {
  return publishedPagesAndPosts.map(function(data) {
    var storedPost = pick(data, INDEXED_PROPERTIES);

    // ... 其他代码 ...

    // 在上传之前过滤 content 字段
    if (storedPost.content) {
      storedPost.content = extractText(storedPost.content);
    }

    return storedPost;
  });
})
```

至此，再次在终端内使用`hexo algolia`指令时就不会报错 too big 了，在 Algolia 的控制台内看上传 item 内的 `content` 字段也非常紧凑了。 
当然，修改源码的方式在重新拉依赖后会被冲掉，心里有数就行。