scaler-packages:
  pkg:
    - installed
    - names:
      - imagemagick
      - ffmpeg2theora
      - librsvg2-bin
      - djvulibre-bin
      - netpbm
      - gsfonts
      - xfonts-scalable
      - xfonts-100dpi
      - xfonts-75dpi
      - xfonts-base
      - xfonts-mplus
      - ttf-liberation
      - ttf-ubuntu-font-family
      - libogg0
      - libvorbisenc2
      - libtheora0
      - oggvideotools
      - libvips-tools
{% if grains['lsb_distrib_release'] == "10.04" %}
      - libvips15
      - ttf-linux-libertine
{% else %}
      - fonts-linuxlibertine
{% endif  %}
