# Blog

{% raw %}
{% for post in posts %}
---

## [{{ post.title }}]({a{ post.url }})
**{{ post.date.strftime('%B %d, %Y') }}**

{{ post.content | safe }}

{% endfor %}
{% endraw %}
