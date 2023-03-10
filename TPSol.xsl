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

        Countries having the most neighbours: <xsl:call-template name="neighbours"/> 

        <hr></hr>

        <xsl:for-each select="//continent[not(preceding::continent/. = .)]">
          <xsl:if test="text()">

            <h3>Pays du continent : <xsl:value-of select="."/> par sous-régions :</h3>

            <xsl:for-each select="//infosContinent[continent=current()]/subregion[not(preceding::subregion/. = .)]">
              <h4><xsl:value-of select="current()"/> (<xsl:value-of select="count(//country/infosContinent[subregion=current()])"/> pays)</h4>
            </xsl:for-each>
          </xsl:if>
        </xsl:for-each>

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


<xsl:template name="neighbours">
    <xsl:for-each select="//country">
      <xsl:sort select="count(borders/*)" order="descending" data-type="number"/>
      <xsl:if test="position() = 1">
          <xsl:value-of select="country_name/common_name" />
          , nb de voisins : <xsl:value-of select="count(country_name/common_name/../../borders/*)"/>
      </xsl:if>
  </xsl:for-each>
</xsl:template>
  
</xsl:stylesheet>