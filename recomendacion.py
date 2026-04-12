
usuarios = {
    "Javier": {"tecnologia", "programacion", "videojuegos"},
    "Ana": {"cine", "romance", "drama"},
    "Luis": {"deportes", "fitness", "salud"}
}

contenidos = {
    "Curso Python": {"tecnologia", "programacion"},
    "Película Romántica": {"cine", "romance"},
    "Rutina de Ejercicio": {"fitness", "salud"},
    "Videojuego FPS": {"videojuegos", "accion"},
    "Documental Tecnología": {"tecnologia", "ciencia"}
}

def calcular_similitud(usuario, contenido):
    interseccion = usuario.intersection(contenido)
    union = usuario.union(contenido)
    
    if len(union) == 0:
        return 0
    
    return len(interseccion) / len(union)

# NUEVO: medir qué tan diferente es
def calcular_diferencia(usuario, contenido):
    diferencia = contenido.difference(usuario)
    return len(diferencia) / len(contenido)

def recomendar(usuario_nombre):
    usuario = usuarios[usuario_nombre]
    
    similares = []
    diferentes = []

    for nombre, contenido in contenidos.items():
        similitud = calcular_similitud(usuario, contenido)
        diferencia = calcular_diferencia(usuario, contenido)

        similares.append((nombre, similitud))
        diferentes.append((nombre, diferencia))

    similares.sort(key=lambda x: x[1], reverse=True)
    diferentes.sort(key=lambda x: x[1], reverse=True)

    return similares, diferentes


print("Usuarios disponibles: Javier, Ana, Luis")
usuario = input("Escribe el nombre del usuario: ")

if usuario in usuarios:
    similares, diferentes = recomendar(usuario)

    print(f"\n Recomendaciones basadas en tus gustos:\n")
    for contenido, score in similares:
        if score > 0:
            print(f"{contenido} -> similitud: {score:.2f}")

    print(f"\n Recomendaciones para probar algo diferente:\n")
    for contenido, score in diferentes:
        if score > 0.5:  # puedes ajustar este filtro
            print(f"{contenido} -> diferente: {score:.2f}")

else:
    print("Usuario no válido. Intenta con: Javier, Ana o Luis.")