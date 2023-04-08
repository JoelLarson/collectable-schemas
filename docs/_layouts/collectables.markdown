---
layout: home
---

<h1>{{ page['collectables']['name'] }}</h1>

<h2>Sets</h2>

<ul>
{% for set in page['collectables']['sets'] %}
<li><a href="/collectable-schemas/collectables/pokemon-tcg/sets/{{ set['id'] }}">{{ set['name'] }}</a></li>
{% endfor %}
</ul>