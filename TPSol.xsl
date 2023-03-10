<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="html"/>
  <xsl:template match="/">
    <html>
      <head>
        <title>Countries of the world</title>
      </head>
      <body>
      <h1> Information about countries </h1>
        <p style="color:green;"><center>Objectif : Données pour illuster le TP du module Données du Web, 3IF, Département Informatique INSA de Lyon </center></p>
        <p> Mise en forme par BORG Lina, DROUILLY Dominique, SIMAR Raphaël (B3129) </p>

        <hr></hr>
        <hr></hr>

        <p>Countries where more than 2 languages are spoken: </p>

        <ul>
          <xsl:apply-templates select="//country[languages[count(*)> 2]]/country_name/common_name">
            <xsl:sort  order="ascending"/>
          </xsl:apply-templates>
        </ul>

        Countries having the most neighbours: , nb de voisins : 

        <hr></hr>

        <h3>Pays du continent : Americas par sous-régions :</h3>

      </body>
    </html>
  </xsl:template>


  <xsl:template match="common_name">
    <li> 
      <xsl:value-of select="." /> : 
      <xsl:apply-templates select="./../../languages"/>
    </li>

  </xsl:template>

  <xsl:template match="languages">
    
    <xsl:for-each select="./*">
      <xsl:value-of select="concat(., ' (', name(.), ')')"/>
      
      <xsl:if test="following-sibling::*"> , </xsl:if> 

    </xsl:for-each>

  </xsl:template>


  
</xsl:stylesheet>