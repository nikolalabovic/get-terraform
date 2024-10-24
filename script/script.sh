#!/bin/bash

# Proveri da li fajl postoji
if [[ ! -f prilog.txt ]]; then
    echo "Fajl prilog.txt ne postoji!"
    exit 1
fi

# Funkcija za kreiranje direktorijuma ako ne postoje
create_directory_if_not_exists() {
    dir="$1"
    if [[ ! -d "$dir" ]]; then
        mkdir -p "$dir"
    fi
}

# Regex za validaciju formata fajla (kABCDEFGH.kod)
regex="^k[0-9a-fA-F]{8}\.kod$"

# Pročitaj listu iz fajla
while IFS= read -r file; do
    # Ukloni suvisne whitespace karaktere
    file=$(echo "$file" | tr -d "\r")

    # Proveri da li je fajl u ispravnom formatu
    if [[ $file =~ $regex ]]; then

        touch "$file"

        # Izdvoji heksadecimalni broj ABCDEFGH iz naziva fajla
        hex="${file:1:8}"

        # Izdvoji sedmi karakter (G) i sesti karakter (E)
        G="${hex:6:1}"
        E="${hex:4:1}"

        # Odredi direktorijum
        if [[ $((0x$G % 2)) -eq 0 ]]; then
            # Ako je G paran broj
            dir="${G}0/${E}0"
        else
            # Ako je G neparan broj
            X=$(printf "%x" $((0x$G - 1)))
            dir="${X}0/${E}0"
        fi


        create_directory_if_not_exists "$dir"


        mv "$file" "$dir/"
    else

        echo "Neispravan naziv fajla: $file"
    fi
done < prilog.txt

