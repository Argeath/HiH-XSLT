<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="xml"/>
  
  <xsl:template match="/">
    <xsl:element name="root">
      <xsl:copy-of select="//typy_pojazdow"/>
      <xsl:copy>
        <xsl:element name="samolotyPasazerskie">
          <xsl:for-each select="//samoloty/samolot">
            <xsl:variable name="model">
              <xsl:value-of select="@model"/>
            </xsl:variable>
            <xsl:variable name="producent">
              <xsl:value-of select="@producent"/>
            </xsl:variable>
            <xsl:element name="{$model}">
              <xsl:attribute name="{$producent}">producent</xsl:attribute>
              <xsl:element name="iloscMiejsc">
                <xsl:value-of select="miejsc"/>
              </xsl:element>
              <xsl:element name="sredniaPredkosc">
                <xsl:value-of select="predkosc_przelotowa"/>
              </xsl:element>
              <xsl:element name="srednieSpalanie">
                <xsl:value-of select="spalanie"/>
              </xsl:element>
            </xsl:element>
          </xsl:for-each>
        </xsl:element>
      </xsl:copy>
    </xsl:element>
  </xsl:template>
</xsl:stylesheet>
