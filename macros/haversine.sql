{% macro haversine_km(lat1, long1, lat2, long2) %}
    round((6371 * acos(
        cos(radians({{ lat1 }})) * cos(radians({{ lat2 }}))
        * cos(radians({{ long2 }}) - radians({{ long1 }}))
        + sin(radians({{ lat1 }})) * sin(radians({{ lat2 }}))
    ))::numeric, 2)
{% endmacro %}