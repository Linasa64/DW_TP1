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
										
											<xsl:apply-templates select="//country[infosContinent/subregion=current()]"/>
										
										
										
										
										
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

  <xsl:template name="neighbours">
    <xsl:for-each select="//country">
      <xsl:sort select="count(borders/*)" order="descending" data-type="number"/>
      <xsl:if test="position() = 1">
          <xsl:value-of select="country_name/common_name" />
          , nb de voisins : <xsl:value-of select="count(country_name/common_name/../../borders/*)"/>
      </xsl:if>
  </xsl:for-each>
</xsl:template>

<xsl:template match="country">
	<tr>
		<td>
		<h5><xsl:value-of select="position()"/></h5>
		</td>
		<td>
			<span style="color:green">
					<xsl:value-of select="current()/country_name/offic_name"/>
			</span>
			
			(<xsl:value-of select="current()/country_name/common_name"/>)
			
			<br/>

			<xsl:if test="current()[country_name/native_name[@lang='fra']][*]">
				<span style="color:blue">
						Nom français : 
						<xsl:value-of select="current()/country_name/native_name[@lang='fra']/offic_name"/>
				</span>
			</xsl:if>
		</td>
		<td>
			<xsl:value-of select="current()/capital"/>
		</td>
		<td>
		    Latitude :  <xsl:value-of select="current()/coordinates/@lat"/>
    <br/>
				Longitude :  <xsl:value-of select="current()/coordinates/@long"/>
    <br/>
		</td>
		<td>
		<xsl:if test="not(current()/borders[*])">
		Island
		</xsl:if>
			<xsl:for-each select="current()/borders/neighbour">
				<xsl:value-of select="//country[country_codes/cca3=current()]/country_name/common_name"/> <xsl:if test="following-sibling::*">, </xsl:if>
			</xsl:for-each>
		
		</td>
		<td>
			<img src="http://www.geonames.org/flags/x/{translate(//country[country_name/common_name[text()=current()/country_name/common_name]]/country_codes/cca2, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz')}.gif" alt="" height="40" width="60"/>
		</td>
		<td>
			<xsl:for-each select="current()/languages/*">
				<xsl:value-of select="current()"/> <xsl:if test="following-sibling::*">, </xsl:if>
			</xsl:for-each>
		</td>
	</tr>

</xsl:template>



</xsl:stylesheet>