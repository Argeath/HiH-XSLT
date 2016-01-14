<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:template match="/">
    <html>
      <head>
        <link rel="stylesheet" href="styles1.css"/>
        <title>XSLT Dominik Kinal 160589</title>
      </head>
      <body>
        <div class="content">
          <h2>Samoloty (<xsl:value-of select='count(//samoloty/samolot)'/>)</h2>
          <table>
            <tr>
              <th>Lp.</th>
              <th>Producent</th>
              <th>Model</th>
              <th>Ilość miejsc</th>
              <th>Średnia prędkość</th>
              <th>Zasięg</th>
              <th>Spalanie kg/km</th>
              <th>Silniki</th>
              <th>Miniatura</th>
              <th>Źródło</th>
            </tr>
            <xsl:apply-templates select="//samoloty/samolot"/>
          </table>

          <xsl:call-template name="separator"/>
          
          <xsl:call-template name="silniki"/>

          <h2>Typy samolotów wojskowych:</h2>
          <ul>
            <xsl:apply-templates select="//typy_pojazdow/*"/>
          </ul>
        </div>
      </body>
    </html>
  </xsl:template>

  <xsl:template name="separator">
    <hr />
  </xsl:template>

  <xsl:template match="//samoloty/samolot">
    <tr>
      <td>
        <xsl:number/>
      </td>
      <td>
        <xsl:value-of select="@producent"/>
      </td>
      <td>
        <xsl:value-of select="@model"/>
      </td>
      <td>
        <xsl:value-of select="miejsc"/>
      </td>
      <td>
        <xsl:apply-templates select="predkosc_przelotowa"/>
      </td>
      <td>
        <xsl:apply-templates select="zasieg"/>
      </td>
      <td>
        <xsl:apply-templates select="spalanie"/>
      </td>
      <td>
        <xsl:value-of select='sum(silniki/silnik/@ilosc)'/>
      </td>
      <td>
        <xsl:apply-templates select='photo'/>
      </td>
      <td>
        <xsl:apply-templates select='info'/>
      </td>
    </tr>
  </xsl:template>

  <xsl:template match='samolot/predkosc_przelotowa'>
    <xsl:variable name='predkosc' select='.'/>
    <xsl:value-of select='round($predkosc div 25) * 25'/> km/h
  </xsl:template>

  <xsl:template match='samolot/spalanie'>
    <xsl:variable name='spalanie' select='.'/>
    <xsl:if test="$spalanie &gt; 6">
      <p style="color: red;">
        <xsl:value-of select='format-number($spalanie, "#0.##")'/>
      </p>
    </xsl:if>
    <xsl:if test="not($spalanie &gt; 6)">
      <p style="color: green;">
        <xsl:value-of select='format-number($spalanie, "#0.##")'/>
      </p>
    </xsl:if>
  </xsl:template>
  
  <xsl:template match="samolot/photo">
    <xsl:variable name="photo" select="."/>
    <img class="thumbnail" src="{$photo}"/>
  </xsl:template>

  <xsl:template match="samolot/info[@url]">
    <a href="{@url}">
      <xsl:value-of select="."/>
    </a>
  </xsl:template>

  <xsl:template match="samolot/zasieg">
    <xsl:variable name="zasieg" select="."/>
    <xsl:choose>
      <xsl:when test="$zasieg &lt; 1000">
        <xsl:value-of select="$zasieg"/> km
      </xsl:when>
      <xsl:when test="$zasieg &gt; 1000">
        <xsl:choose>
        <xsl:when test="$zasieg mod 1000 &lt; 250">
          <xsl:value-of select='round($zasieg div 1000)'/> tys. km
        </xsl:when>
        <xsl:when test='$zasieg mod 1000 &lt; 750'>
          <xsl:value-of select='round($zasieg div 1000)'/>.5 tys. km
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select='round($zasieg div 1000)'/> tys. km
        </xsl:otherwise>
        </xsl:choose>
      </xsl:when>
    </xsl:choose>
  </xsl:template>

  <xsl:template name='silniki'>
    <h2>Silniki (<xsl:value-of select='count(//silniki/silnik[not(.=preceding::*)])'/>)</h2>
    <table>
      <tr>
        <th>Lp.</th>
        <th>Producent</th>
        <th>Model</th>
        <th>Ciąg</th>
        <th>Waga</th>
      </tr>
      <xsl:for-each select='//silniki/silnik[not(.=preceding::*)]'>
        <xsl:sort select='ciag' case-order='upper-first'/>
        <tr>
          <td>
            <xsl:number value='position()' format='I'/>
          </td>
          <td>
            <xsl:value-of select='@producent'/>
          </td>
          <td>
            <xsl:value-of select='@model'/>
          </td>
          <td>
            <xsl:apply-templates select='ciag'/>
          </td>
          <td>
            <xsl:apply-templates select='waga'/>
          </td>
        </tr>
      </xsl:for-each>
    </table>
  </xsl:template>

  <xsl:template match='silnik/ciag'>
    <xsl:variable name='ciag' select='.'/>
    <xsl:value-of select='$ciag'/> kN
  </xsl:template>

  <xsl:template match='silnik/waga'>
    <xsl:variable name='waga' select='.'/>
    <xsl:value-of select='$waga'/> kg
  </xsl:template>

  <xsl:template match='bojowy | pomocniczy'>
    <li>
      <xsl:value-of select='.'/>
    </li>
  </xsl:template>
</xsl:stylesheet>
