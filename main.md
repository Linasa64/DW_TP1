# First part : XML, DTD, XPath, XSLT

## Step 1: Exploring the instance [XPath]


### 1. the official names (country_name/offic_name) of the countries
`//country_name/offic_name`

### 2. the latitude of each country
`//coordinates/@lat`

### 3. the area of each country
`//country/@area`

### 4. the official names of European countries (continent = Europe)
`//country[infosContinent/continent[text()="Europe"]]/country_name/offic_name`

### 5. the common names of countries that do not have any native name
Que l'Antarctique ! 

`//country/country_name[not(native_name)]/offic_name`

### 6. the official names of the countries expressed in French, for those who have such names
`//country/country_name[native_name[@lang="fra"]]/offic_name`

### 7. elements with at least one attribute
Not distinct element ?

`//*[@*]`

### 8. official names of the second native name of countries (for those who have)
`//country_name/native_name[2]/offic_name`

### 9. the sum of the surfaces (area) of the countries of Africa
`sum(//country[infosContinent/continent[text()="Africa"]]/@area`

### 10. countries whose common name is not contained in their official name
`//country_name[offic_name[not(contains(text(), ../common_name/text()))]]/offic_name`

### 11. France's last neighbor
`//country[country_name/common_name[text()="France"]]/borders/neighbour[last()]`

### 12. the position of France in the XML document
On compte tous ceux d'avant et on ajoute un pour la vraie position (on compte la France aussi)

`count(//country[country_name/common_name="France"]/preceding::country)+1`


## Step 2: Instance update [XML, DTD]

Trouver le pays sans tld :
`//country[not(tld)]/country_name/common_name`

On prend toutes les instances avec une * et on regarde combien il y en a de vides

`count(//country)-count(//country[tld])` --> 1

`count(//country)-count(//country[tlcurrencyd])` --> 1

`count(//country)-count(//country[callingCode])` --> 5

`count(//country)-count(//country[altSpellings])` --> 0

`count(//country)-count(//country[infosContinent])` --> 0

`count(//country)-count(//country[languages])` --> 0

`count(//country)-count(//country[coordinates])` --> 1

`count(//country)-count(//country[borders])` --> 82

Pour tous ces pays, on remplace * par + car ils peuvent en avoir de 1 à n.

On remarque aussi que tous les pays ont un continent :
`count(//country)-count(//country/infosContinent[continent])` --> 0

Comme tous les pays ont un et un seul continent, on ne pas de + mais rien cette fois.


Au final on change comme ça : 

`<!ELEMENT country (country_name,tld*,country_codes,currency*,callingCode*,
                   capital,altSpellings+, infosContinent+,languages+,
                   coordinates*,demonym,landlocked,borders*)>`