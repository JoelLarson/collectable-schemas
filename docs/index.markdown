---
layout: home
---

# Collectables

<ul>
{% for collectables_entry in page['collectables_list'] %}
<li><a href="collectables/{{ collectables_entry['id'] }}">{{ collectables_entry['name'] }}</a></li>
{% endfor %}
</ul>