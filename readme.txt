Testele pentru verificarea temei 

1. Pentru a seta environmentul trebuie sa rulati urmatoarele comenzi: 

$ apt-get update
$ apt-get install python3-pycryptodome xinetd libffi-dev python3-wheel gcc gdb python3-setuptools python3-dev libssl-dev git libc6-dbg python3-pip make gcc-multilib socat

2. Dupa ce ati instalat pachetele de mai sus, trebuie sa va asigurati ca in acelasi folder cu script.py se regasesc sursele voastre denumite corespunzator.

3. Rulati scriptul prin comanda 
$ python3 script.py 

Veti primi in consola un raport referitoare la testele care au fost trecute cu succes, respectiv testele esuate. Pentru fiecare test esuat, puteti vedea inputul primit, ce output ati oferit, respectiv outputul asteptat. 

Daca vreti rezultatele intr-un fisier, puteti rula comanda

$ python3 script.py > result.txt

4. Pot fi adaugate teste facute de voi, adaugand in listele de testele un fisier in care sa se regaseasca inputul si adaugand outputul in script similar cu testul dat ca exemplu.

IMPORTANT! Punctajul obtinut pe aceste teste este estimativ, si pot aparea diferente la evaluarea finala, care va fi pe alte teste. 

