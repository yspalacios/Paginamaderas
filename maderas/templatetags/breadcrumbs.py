# maderas/templatetags/breadcrumbs.py
from django import template
from django.urls import resolve, Resolver404, reverse
from django.utils.text import capfirst

register = template.Library()

@register.inclusion_tag('breadcrumbs.html', takes_context=True)
def breadcrumbs(context):
    """
    Genera breadcrumbs usando los `name` de las URLs cuando estén definidos.
    """
    request = context.get('request')
    if not request:
        return {'crumbs': []}

    # Limpiamos la ruta y obtenemos segmentos
    path = request.path.strip('/')
    segments = path.split('/') if path else []

    # Siempre iniciamos con "Inicio"
    crumbs = [{'name': 'Inicio', 'url': reverse('inicio')}]

    acum = ''
    for seg in segments:
        acum += f'/{seg}'
        try:
            match = resolve(acum)
            # Usamos el url_name si existe, sino el propio segmento
            label = match.url_name or seg
            friendly = capfirst(label.replace('_', ' ').replace('-', ' '))
            crumbs.append({'name': friendly, 'url': acum})
        except Resolver404:
            # Segmentos sin vista (por ejemplo IDs)
            friendly = capfirst(seg.replace('_', ' ').replace('-', ' '))
            crumbs.append({'name': friendly, 'url': None})

    return {'crumbs': crumbs}
