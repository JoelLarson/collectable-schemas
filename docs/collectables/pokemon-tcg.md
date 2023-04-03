---
layout: home
---

## {{ site.data['collectables']['pokemon-tcg']['name'] }}

### Sets

<table>
<tr>
    <th>Set Name</th>
    <th>Locale</th>
    <th>Number</th>
    <th>Name</th>
    <th>SS</th>
    <th>SSF</th>
    <th>PS</th>
</tr>
{% for set in site.data['collectables']['pokemon-tcg']['sets'] %}

{% for locale in set['locales'] %}


{% for card in locale['cards'] %}
<tr>
<td>{{ set['name'] }}</td>
<td>{{ locale['id'] }}</td>
<td>{{ card['id'] }}</td>
<td>{{ card['name'] }}</td>
<td>
    {% if card['variants'] contains 'standard-set' %}
    <span style="display:block;text-align:center;background-color: black; color: #fefefe;padding: 3px;">SS</span>
    {% endif %}
</td>
<td>
    {% if card['variants'] contains 'standard-set-foil' %}
    <span style="display:block;text-align:center;background-color: red; color: #fefefe;padding: 3px;">SSF</span>
    {% endif %}
</td>
<td>
    {% if card['variants'] contains 'parallel-set' %}
    <span style="display:block;text-align:center;background-color: blue; color: #fefefe;padding: 3px;">PS</span>
    {% endif %}
</td>
</tr>
{% endfor %}


{% endfor %}

{% endfor %}
</table>