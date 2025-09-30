
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

#### Iniciem els dos repositoris utilitzant el script de init_repo
``./init_repo``

#### Crea la carpeta repo-xxx i amz.
 `cd repo-xxx`

#### Fem la creació de la nova branca
`git checkout -b branca_mostra`

#### Fer modificacions de fitxers, afegir carpetes, etc.

### A l'arrel de la carpeta ``repositori`` :

#### Es fa el commit
>``./duplicar git commit -m 'missatge del commit'``
#### Es publica la branca_mostra a GitHub
>``./duplicar git push origin branca_mostra``
#### Es fa merge de branca_mostra al main de GitHub
>``./duplicar git merge branca_mostra``
#### Es torna fer commit ara amb el merge
>``./duplicar git commit -m 'missatge del commit merge'``
#### Es publica la branca_mostra al main de GitHub i es copia el main de GitHub al pre del repositori de Amazon
>``./duplicar git push origin main``
