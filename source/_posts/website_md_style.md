---
title: Markdown 高阶语法验证
date: 2014-04-16
categories: Website
id: blog002
mathjax: true
---
本文作为存档备份，每次切换转义框架或主题时，以此文档验证该环境下markdown各语法是否支持以及样式是否美观。

## Quick Start

## 化学公式


### 化学方程式表示





## 数学公式

### 基本字符

### 多行多项式
```

```

“$” 表示行内公式：

质能守恒方程可以用一个很简洁的方程式 $\ E=mc^2$ 来表达。 `$\ E=mc^2$`

求和公式 $\sum_{i=0}^n i^2 = \frac{(n^2+n)(2n+1)}{6}$。 

```js
$\sum_{i=0}^n i^2 = \frac{(n^2+n)(2n+1)}{6}$`
```

复杂一点的公式
$J_\alpha(x) = \sum_{m=0}^\infty \frac{(-1)^m}{m! \Gamma (m + \alpha + 1)} {\left({ \frac{x}{2} }\right)}^{2m + \alpha}$  后方可添加注释

```js
$J_\alpha(x) = \sum_{m=0}^\infty \frac{(-1)^m}{m! \Gamma (m + \alpha + 1)} {\left({ \frac{x}{2} }\right)}^{2m + \alpha}$
```

单行长函数 
$f(x_1,x_2,\underbrace{\ldots}_{\rm ldots} ,x_n) = x_1^2 + x_2^2 + \underbrace{\cdots}_{\rm cdots} + x_n^2$

```js
$f(x_1,x_2,\underbrace{\ldots}_{\rm ldots} ,x_n) = x_1^2 + x_2^2 + \underbrace{\cdots}_{\rm cdots} + x_n^2$
```


“$$” 表示整行公式：

取极限
$$ 
\lim_{n \to +\infty} \frac{1}{n(n+1)} \quad or \quad \lim_{x\leftarrow{sample}} \frac{1}{n^2+1} 
$$

```js
$$
\lim_{n \to +\infty} \frac{1}{n(n+1)} \quad or \quad \lim_{x\leftarrow{sample}} \frac{1}{n^2+1} 
$$
```

矩阵与省略号
$$
        x =
        \begin{pmatrix}
        1 & a_1 & a_1^2 & \cdots & a_1^n \\
        1 & a_2 & a_2^2 & \cdots & a_2^n \\
        \vdots & \vdots & \vdots & \ddots & \vdots \\
        1 & a_m & a_m^2 & \cdots & a_m^n \\
        \end{pmatrix}
$$
```js
$$
        f(m,n)=
        \begin{pmatrix}
        1 & a_1 & a_1^2 & \cdots & a_1^n \\
        1 & a_2 & a_2^2 & \cdots & a_2^n \\
        \vdots & \vdots & \vdots & \ddots & \vdots \\
        1 & a_m & a_m^2 & \cdots & a_m^n \\
        \end{pmatrix}
$$
```

多重积分符号
$$
\begin{array}{cc}
\mathrm{Bad} & \mathrm{Better} \\
\hline \\
\int\int_S f(x)\,dy\,dx & \iint_S f(x)\,dy\,dx \\
\int\int\int_V f(x)\,dz\,dy\,dx & \iiint_V f(x)\,dz\,dy\,dx
\end{array}
$$

```
$$
\begin{array}{cc}
\mathrm{Bad} & \mathrm{Better} \\
\hline \\
\int\int_S f(x)\,dy\,dx & \iint_S f(x)\,dy\,dx \\
\int\int\int_V f(x)\,dz\,dy\,dx & \iiint_V f(x)\,dz\,dy\,dx
\end{array}
$$
```
有些符号会产生不合适的间隔，需要手动添加间隔符 

$$
\begin{array}{cc}
\mathrm{Bad} & \mathrm{Better} \\
\hline \\
\{x|x^2\in\Bbb Z\} & \{x\mid x^2\in\Bbb Z\} \\
\end{array}
$$

```
$$
\begin{array}{cc}
\mathrm{Bad} & \mathrm{Better} \\
\hline \\
\{x|x^2\in\Bbb Z\} & \{x\mid x^2\in\Bbb Z\} \\
\end{array}
$$
```

箭头指向
$$
\begin{CD}
    A @>>> B @>{\text{very long label}}>> C \\
    @. @AAA @| \\
    D @= E @<<< F
\end{CD}
$$
$$
\begin{CD}
    A @>a>> B\\
    @V b V V\# @VV c V\\
    C @>>d> D
\end{CD}
$$

```
$$
\begin{CD}
    A @>>> B @>{\text{very long label}}>> C \\
    @. @AAA @| \\
    D @= E @<<< F
\end{CD}
$$
$$
\begin{CD}
    A @>a>> B\\
    @V b V V\# @VV c V\\
    C @>>d> D
\end{CD}
$$
```

啊啊

底部分割


<details>
	<summary>折叠文本</summary>
	`hexo`是什么？
	#### 啊啊啊啊啊eeee鹅鹅鹅饿
</details>

## 问答

<details>
  <summary>什么是tinper</summary>
    
`tinper`是开源前端技术平台。<br>
 鹅鹅鹅饿
 ##### 啊啊啊啊啊eeee鹅鹅鹅饿
    
 ```
    int a = 0;
    
 ```
</details>