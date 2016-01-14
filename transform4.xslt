<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:java="http://xml.apache.org/xslt/java" exclude-result-prefixes="java" version="1.0" xmlns="http://www.w3.org/1999/xhtml">
  <xsl:output method="xml" version="1.0" indent="yes" encoding="UTF-8" xml:lang="pl-pl"/>

  <xsl:template match="/">
    <fo:root xmlns:fo="http://www.w3.org/1999/XSL/Format">

      <fo:layout-master-set>
        <fo:simple-page-master master-name="Tytulowa" margin="10mm" page-width="300mm" page-height="150mm">
          <fo:region-body margin="30mm"/>
          <fo:region-after extent="30mm"/>
        </fo:simple-page-master>

        <fo:simple-page-master master-name="Samolot" margin="10mm" page-width="150mm" page-height="200mm">
          <fo:region-body margin="20mm"/>
          <fo:region-before extent="20mm"/>
          <fo:region-after extent="10mm"/>
        </fo:simple-page-master>

        <fo:simple-page-master master-name="Silnik" margin="10mm" page-width="150mm" page-height="200mm">
          <fo:region-body margin="20mm"/>
          <fo:region-before extent="20mm"/>
          <fo:region-after extent="10mm"/>
        </fo:simple-page-master>
        
        <fo:simple-page-master master-name="Spis" margin="10mm" page-width="150mm" page-height="200mm">
          <fo:region-body margin="20mm"/>
          <fo:region-before extent="20mm"/>
          <fo:region-after extent="10mm"/>
        </fo:simple-page-master>
      </fo:layout-master-set>

      <fo:page-sequence master-reference="Tytulowa">
        <fo:static-content flow-name="xsl-region-after">
          <fo:block text-align="center" font-size="30pt">
            <xsl:text>Dominik Kinal 160589</xsl:text>
          </fo:block>
        </fo:static-content>
        <fo:flow flow-name="xsl-region-body">
          <fo:block text-align="center">
            <fo:inline font-size="50pt">Lotnictwo</fo:inline>
          </fo:block>
        </fo:flow>
      </fo:page-sequence>

      <fo:page-sequence master-reference="Samolot">
        <fo:static-content flow-name="xsl-region-before">
            <fo:block text-align-last="justify" font-size="10pt">
              <fo:inline>
              <xsl:text>Lotnictwo</xsl:text>
              </fo:inline>
              <fo:leader leader-pattern="space" />
              <fo:inline>
                <xsl:text>Dominik Kinal</xsl:text>
              </fo:inline>
            </fo:block>
          <fo:block text-align="center" font-size="20pt">
            <xsl:text>Samolot</xsl:text>
          </fo:block>
        
        </fo:static-content>
        <fo:static-content flow-name="xsl-region-after">
          <fo:block text-align="center" font-size="10pt">
              <xsl:text>Strona </xsl:text>
              <fo:page-number/>
          </fo:block>
        </fo:static-content>
        <fo:flow flow-name="xsl-region-body">
          <fo:block text-align="center" font-size="30pt">
            <xsl:apply-templates select="//samoloty/samolot"/>
          </fo:block>
        </fo:flow>
      </fo:page-sequence>
      
      <fo:page-sequence master-reference="Silnik">
        <fo:static-content flow-name="xsl-region-before">
          <fo:block text-align="center" font-size="20pt">
            <xsl:text>Silnik</xsl:text>
          </fo:block>
        </fo:static-content>
        <fo:static-content flow-name="xsl-region-after">
          <fo:block text-align-last="justify" font-size="10pt">
            <fo:inline>
              <xsl:text>Lotnictwo</xsl:text>
            </fo:inline>
            <fo:leader leader-pattern="space" />
            <fo:inline>
              <xsl:text>Strona </xsl:text>
              <fo:page-number/>
            </fo:inline>
          </fo:block>
        </fo:static-content>
        <fo:flow flow-name="xsl-region-body">
          <fo:block text-align="center" font-size="30pt">
            <xsl:call-template name="silniki"/>
          </fo:block>
        </fo:flow>
      </fo:page-sequence>

      <fo:page-sequence master-reference="Spis">
        <fo:static-content flow-name="xsl-region-after">
          <fo:block text-align-last="justify" font-size="10pt">
            <fo:inline>
              <xsl:text>Lotnictwo</xsl:text>
            </fo:inline>
            <fo:leader leader-pattern="space" />
            <fo:inline>
              <xsl:text>Strona </xsl:text>
              <fo:page-number/>
            </fo:inline>
          </fo:block>
        </fo:static-content>
        <fo:flow flow-name="xsl-region-body">
          <fo:block text-align="left">
            <fo:block font-size="20pt">Samoloty:</fo:block>
            <fo:list-block>
            <xsl:for-each select="//samoloty/samolot">
              <fo:list-item>
                <fo:list-item-label>
                  <fo:block>
                    <xsl:number value='position()'/>.
                  </fo:block>
                </fo:list-item-label>
                <fo:list-item-body start-indent="5mm">
                  <fo:block>
                    <xsl:value-of select="@producent"/>&#160;<xsl:value-of select="@model"/>
                  </fo:block>
                </fo:list-item-body>
              </fo:list-item>
            </xsl:for-each>
            </fo:list-block>
            <fo:block font-size="20pt" space-before="20pt">Silniki:</fo:block>
            <fo:list-block>
              <xsl:for-each select='//silniki/silnik[not(.=preceding::*)]'>
                <xsl:sort select='ciag' case-order='upper-first'/>
                <fo:list-item>
                  <fo:list-item-label>
                    <fo:block>
                      <xsl:number value='position()'/>.
                    </fo:block>
                  </fo:list-item-label>
                  <fo:list-item-body start-indent="5mm">
                    <fo:block>
                      <xsl:value-of select="@producent"/>&#160;
                      <xsl:value-of select="@model"/>
                    </fo:block>
                  </fo:list-item-body>
                </fo:list-item>
              </xsl:for-each>
            </fo:list-block>
          </fo:block>
        </fo:flow>
      </fo:page-sequence>
    </fo:root>
  </xsl:template>

  <xsl:template match="//samoloty/samolot">
    <fo:block font-size="14pt" font-family="Arial" page-break-after="always">
      <fo:block>
        <fo:external-graphic content-height="scale-to-fit" height="2.00in"  content-width="3.00in">
          <xsl:attribute name="src">
            <xsl:value-of select="photo"/>
          </xsl:attribute>
        </fo:external-graphic>
      </fo:block>
      <fo:table>
        <fo:table-body>
          <fo:table-row>
            <fo:table-cell>
              <fo:block text-align="left">
                <xsl:text>Producent</xsl:text>
              </fo:block>
            </fo:table-cell>
            <fo:table-cell>
              <fo:block text-align="right">
                <xsl:value-of select="@producent"/>
              </fo:block>
            </fo:table-cell>
          </fo:table-row>

          <fo:table-row>
            <fo:table-cell>
              <fo:block text-align="left">
                <xsl:text>Model</xsl:text>
              </fo:block>
            </fo:table-cell>
            <fo:table-cell>
              <fo:block text-align="right">
                <xsl:value-of select="@model"/>
              </fo:block>
            </fo:table-cell>
          </fo:table-row>

          <fo:table-row>
            <fo:table-cell>
              <fo:block text-align="left">
                <xsl:text>Predkosc przelotowa</xsl:text>
              </fo:block>
            </fo:table-cell>
            <fo:table-cell>
              <fo:block text-align="right">
                <xsl:value-of select="predkosc_przelotowa"/> km/h
              </fo:block>
            </fo:table-cell>
          </fo:table-row>
          
          <fo:table-row>
            <fo:table-cell>
              <fo:block text-align="left">
                <xsl:text>Ilosc miejsc</xsl:text>
              </fo:block>
            </fo:table-cell>
            <fo:table-cell>
              <fo:block text-align="right">
                <xsl:value-of select="miejsc"/>
              </fo:block>
            </fo:table-cell>
          </fo:table-row>
          
          <fo:table-row>
            <fo:table-cell>
              <fo:block text-align="left">
                <xsl:text>Zasieg</xsl:text>
              </fo:block>
            </fo:table-cell>
            <fo:table-cell>
              <fo:block text-align="right">
                <xsl:value-of select="zasieg"/> km
              </fo:block>
            </fo:table-cell>
          </fo:table-row>
        </fo:table-body>
      </fo:table>
    </fo:block>
  </xsl:template>

  <xsl:template name='silniki'>
    <fo:block font-size="14pt" font-family="Arial" page-break-after="always">
          <xsl:for-each select='//silniki/silnik[not(.=preceding::*)]'>
            <xsl:sort select='ciag' case-order='upper-first'/>
            <fo:block break-after="page">
              <fo:block>
                <fo:external-graphic content-height="scale-to-fit" height="1.50in" content-width="3.00in">
                  <xsl:attribute name="src">
                    <xsl:value-of select="photo"/>
                  </xsl:attribute>
                </fo:external-graphic>
              </fo:block>
              <fo:table>
                <fo:table-body>
                  <fo:table-row>
                    <fo:table-cell>
                      <fo:block text-align='left'>Producent</fo:block>
                    </fo:table-cell>
                    <fo:table-cell>
                      <fo:block text-align='right'>
                        <xsl:value-of select='@producent'/>
                      </fo:block>
                    </fo:table-cell>
                  </fo:table-row>
                  <fo:table-row>
                    <fo:table-cell>
                      <fo:block text-align='left'>Model</fo:block>
                    </fo:table-cell>
                    <fo:table-cell>
                      <fo:block text-align='right'>
                        <xsl:value-of select='@model'/>
                      </fo:block>
                    </fo:table-cell>
                  </fo:table-row>
                  <fo:table-row>
                    <fo:table-cell>
                      <fo:block text-align='left'>Ciag</fo:block>
                    </fo:table-cell>
                    <fo:table-cell>
                      <fo:block text-align='right'>
                        <xsl:value-of select='ciag'/> kN
                      </fo:block>
                    </fo:table-cell>
                  </fo:table-row>
                  <fo:table-row>
                    <fo:table-cell>
                      <fo:block text-align='left'>Waga</fo:block>
                    </fo:table-cell>
                    <fo:table-cell>
                      <fo:block text-align='right'>
                        <xsl:value-of select='waga'/> kg
                      </fo:block>
                    </fo:table-cell>
                  </fo:table-row>
                </fo:table-body>
              </fo:table>
            </fo:block>
          </xsl:for-each>
    </fo:block>
  </xsl:template>

</xsl:stylesheet>