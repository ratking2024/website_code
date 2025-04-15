{# sitemap.swig #}
{% extends '_layout.swig' %}

{% block title %}{{ __('sitemap') }} | {{ title }}{% endblock %}

{% block content %}
<style>
    .sitemap-page {
      padding: 20px;
    }
    .sitemap-grid {
      display: grid;
      grid-template-columns: repeat(auto-fit, minmax(100px, 1fr)); /* 响应式网格布局 */
      grid-gap: 0; /* 移除网格间距 */
    }
    .sitemap-grid a {
      text-decoration: none; /* 移除特定区域超链接的下划线 */
      border-bottom: none !important;
    }

    .grid-item {
      background-color: transparent; /* 使得格子在非悬浮状态下不可见 */
      border: none !important; /* 确保没有边框 */
      box-shadow: none !important; /* 确保没有阴影 */
      overflow: hidden !important;
      transition: background-color 0.3s ease;
      text-align: center; /* Center the content */
    }
    .grid-item a {
      text-decoration: none; /* 移除特定区域超链接的下划线 */
    }
    .grid-item:hover {
      background-color: #f0f0f0; /* A light grey background on hover */
    }
    .grid-link {
      display: flex;
      flex-direction: column;
      align-items: center;
      text-decoration: none;
      color: inherit;
      padding: 10px; /* Add some padding */
    }
    .grid-icon {
      width: 60px;
      height: 60px;
      margin-top: 0px;
      border-radius: 10%;
      object-fit: cover;
    }

    .grid-name {
      margin: 5px 0px 0px 0px;
      font-size: 14px;
      font-weight: bold;
      color: #333;
    }

    .grid-desc {
      margin: -5px 0px 0px 0px;
      font-size: 10px;
      font-weight: bold;
      color: #333;
    }
  </style>

  <div class="post-block">
    {% for category, links in site.data.links %}
      <h2 class="sitemap-category-title">{{ category }}</h2>
      <div class="sitemap-grid">
        {% for link in links %}
          <div class="grid-item">
            <a href="{{ link.url }}" target="_blank" rel="noopener" class="grid-link">
              <img src="{{ link.img }}" alt="{{ link.name }}" class="grid-icon">
              <div class="grid-name">{{ link.name }}</div>
              <div class="grid-desc">{{ link.desc }}</div>
            </a>
          </div>
        {% endfor %}
      </div>
    {% endfor %}
  </div>
{% endblock %}