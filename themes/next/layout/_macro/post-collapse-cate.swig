{% macro render(posts) %}
{%- for post in posts.toArray() %}

  <article itemscope itemtype="http://schema.org/Article" class="post-article">
    <header class="post-header">
      <div class="post-title-and-thumbnail">
        <div class="post-title-and-excerpt">
          <div class="post-title">
            {%- if post.link %}
              {%- set postTitleIcon = '<i class="fa fa-external-link-alt"></i>' %}
              {%- set postText = post.title or post.link %}
              {{ next_url(post.link, postText + postTitleIcon, {class: 'post-title-link post-title-link-external', itemprop: 'url'}) }}
            {% else %}
              <a class="post-title-link" href="{{ url_for(post.path) }}" itemprop="url">
                <span itemprop="name">{{ post.title or __('post.untitled') }}</span>
              </a>
            {%- endif %}
          </div>
          <div class="post-excerpt">
            {{ post.excerpt | striptags | truncate(200) }}
          </div>
        </div>
        {%- set firstImage = first_image(post.content) %}
        {%- if firstImage %}
          <div class="post-thumbnail">
            <img src="{{ url_for(firstImage) }}" alt="{{ post.title | escape }}" class="thumbnail-image">
          </div>
        {%- endif %}
      </div>
      <div class="post-meta">
        <time itemprop="dateCreated"
              datetime="{{ moment(post.date).format() }}"
              content="{{ date(post.date, config.date_format) }}">
          {{ date(post.date, 'YYYY-MM-DD') }}
        </time>
      </div>
    </header>
  </article>

{%- endfor %}
{% endmacro %}
