---
layout: home
---

<h1>{{ page['set']['name'] }}</h1>

{% for locale in page['set']['locales'] %}

<a href="locales/{{ locale['id'] }}">{{ locale['id'] }}</a>

<table>
<tr>
    <th>ID</th>
    <th>Name</th>
</tr>
{% for cards in locale['cards'] %}
<tr>
    <td><a href="locales/{{ locale['id'] }}/cards/{{ cards['id'] }}">{{ cards['id'] }}</a></td>
    <td>{{ cards['name'] }}</td>
</tr>
{% endfor %}
</table>

{% endfor %}