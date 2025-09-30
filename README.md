
# Sincronització dels repos

###### Sincronitzar dos gits en dues carpetes diferents i amb dos usuaris diferents 

``` 
repositori-xxx      (carpeta superior amb els dos repos)
├── init_repo.sh    (bash on es fara la inicialització)
├── duplicar.sh     (bash on farem les instruccions)
├── amz             (repo de codecommit)
└── repo-XXX        (repo de github)
```

## Descripció dels fitxers i carpetes

* ` ./init_repo.sh`
>Clona els dos repos (amz i github) a les carpetes amz i repo-xxx. El repositori de amz es posa en branca "pre"

* ` ./duplicar.sh`
>Duplica les instruccions de git que se li fagin. Es fan tant a amz com al repo de github

* ` /amz`
>Carpeta que conté el repositori de AWS CodeCommit

* `/repo-XXX`
>Carpeta que conté el repositori de GitHub

## Instruccions

#### 1. ``./init_repo``
Afegir el link de AWS amb l'usuari i la contrasenya.
#### 2. *git branch dins de repo-XXX*
#### 3. Editar fitxers, creació, desenvolupar, etc.
#### 4. Per publicar:
> git commit -m 'missatge' 

Això fa un git add de tots els canvis, sincronitza la carpeta amz amb les modificacions, fa un pull de amz i fa un commit dins del repo de amz.

> git push origin branca_de_github

Amb el commit ja fet ara el que es fa es pujar la branca al repo de GitHub i es fa push de la branca de pre a CodeCommit.
