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

        <xsl:for-each select="//continent[not(preceding::continent/. = .)]">
          <xsl:if test="text()">

            <h3>Pays du continent : <xsl:value-of select="."/> par sous-régions :</h3>

            <xsl:for-each select="//infosContinent[continent=current()]/subregion[not(preceding::subregion/. = .)]">
              <h4><xsl:value-of select="current()"/> (<xsl:value-of select="count(//country/infosContinent[subregion=current()])"/> pays)</h4>
                <table border="3" width="100%" align="center">
                    <tbody>
                        <tr>
                            <th> N°</th> 
                            <th> Name </th> 
                            <th> Capital </th> 
                            <th> Coordinates </th> 
                            <th> Neighbours </th>
                            <th> Flag </th>
                            <th> Spoken Languages </th>
                        </tr>

                        


                    </tbody>
                </table>
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



  <xsl:template match="country_name">
    <span> style="color:green">
        <xsl:value-of select="//current()/country_name/offic_name">
    <span>
    (
        <xsl:value-of select="//current()/country_name/common_name">
    )
    <br>

    <xsl:if test="//current()[(native_name[@lang='fra'])] != text()">
        <span> style="color:blue">
            Nom français : 
            <xsl:value-of select="//current()/native_name[@lang='fra']/offic_name">
        <span>    
    </xsl:if>

  </xsl:template>

  <xsl:template match="coordinates">
    Latitude :  <xsl:value-of select="//current()/coordinates/@lat">
    <br>
    Longitude :  <xsl:value-of select="//current()/coordinates/@long">
    <br>
  </xsl:template> 

  <xsl:template match="neighbour">
    <xsl:for-each select="current()/borders/neighbour">,
        <xsl:value-of select="./*">
    </xsl:for-each>
  </xsl:template> 


  
</xsl:stylesheet>



<xsl:template match="country_name">
	<span style="color:green">
			<xsl:value-of select="//current()/country_name/offic_name"/>
	</span>
	(
			<xsl:value-of select="//current()/country_name/common_name"/>
	)
	<br>

	<xsl:if test="//current()[(native_name[@lang='fra'])] != text()">
			<span style="color:blue">
					Nom français : 
					<xsl:value-of select="//current()/native_name[@lang='fra']/offic_name"/>
			</span>
	</xsl:if>

</xsl:template>





