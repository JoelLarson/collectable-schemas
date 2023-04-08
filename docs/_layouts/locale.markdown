---
layout: home
---

<h1>{{ page['_locale']['id'] }}</h1>

<table>
<tr>
    <th>ID</th>
    <th>Name</th>
</tr>
{% for cards in page['_locale']['cards'] %}
<tr>
    <td><a href="cards/{{ cards['id'] }}">{{ cards['id'] }}</a></td>
    <td>{{ cards['name'] }}</td>
</tr>
{% endfor %}
</table>