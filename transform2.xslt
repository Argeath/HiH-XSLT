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
          <h2>
            Samoloty (<xsl:value-of select='count(//samoloty/samolot)'/>)
          </h2>
          <xsl:for-each select='//samoloty/samolot'>
            <div class='samolotBox'>
              <xsl:apply-templates select='photo'/>
              <b>
                <xsl:value-of select='@producent'/>&#160;<xsl:value-of select='@model'/>
              </b><br />
              Miejsc: <xsl:apply-templates select='miejsc'/><br />
              Spalanie: <xsl:apply-templates select='spalanie'/>
            </div>
          </xsl:for-each>
        </div>
      </body>
    </html>
  </xsl:template>

  <xsl:template match='samolot/miejsc'>
    <xsl:variable name='miejsc' select='.'/>
    <xsl:variable name='people' select='$miejsc div 50'/>
    <xsl:for-each select='(//node())[$people >= position()]'>
      <img class='personIcon' src='person.png'/>
    </xsl:for-each>
  </xsl:template>

  <xsl:template match='samolot/spalanie'>
    <xsl:variable name='spalanie' select='.'/>
    <xsl:if test="$spalanie &gt; 6">
        duże
    </xsl:if>
    <xsl:if test="not($spalanie &gt; 6)">
        małe
    </xsl:if>
  </xsl:template>

  <xsl:template match="samolot/photo">
    <xsl:variable name="photo" select="."/>
    <img class="thumbnail" src="{$photo}"/>
  </xsl:template>
</xsl:stylesheet>
