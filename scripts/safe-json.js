// scripts/safe-json.js

// scripts/safe-json.js
hexo.extend.helper.register('safePostsJSON', function(posts) {
  return JSON.stringify(posts.map(post => {
    return {
      title: post.title,
      date: post.date,
      path: post.path,
      cateId: post.categoryid,

      // ...其他你需要的属性
    };
  }));
});


hexo.extend.helper.register('typeof', function(variable) {
  return Object.prototype.toString.call(variable);
});

// scripts/find-first-image.js
hexo.extend.helper.register('first_image', function(content) {
  const regex = /<img [^>]*src="([^"]+)"[^>]*>/;
  const match = regex.exec(content);
  return match ? match[1] : null;
});
