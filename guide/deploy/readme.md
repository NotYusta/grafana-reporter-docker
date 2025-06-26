# 📦 Panduan Deploy Grafana Stack di Portainer
## ⚠️ Catatan Penting

Sebelum mengupdate atau melakukan perubahan pada Grafana, **lakukan backup data terlebih dahulu**

---

## 🧭 Langkah-langkah Deploy

1. **Buka halaman Portainer** melalui browser.
2. Navigasi ke menu **"Stacks"** di sidebar.
3. Klik tombol **"Add Stack"**.
4. Isi nama stack, misalnya: `grafana`.
5. Pilih metode **"Web Editor"**.
6. Salin dan tempel konfigurasi berikut:

```yaml
version: '3.8'

networks:
  grafana:
    name: grafana

volumes:
  grafana_data:

services:
  grafana:
    image: grafana/grafana:latest
    container_name: grafana
    ports:
      - "3000:3000"
    environment:
      - GF_SECURITY_ADMIN_USER=admin
      - GF_SECURITY_ADMIN_PASSWORD=admin
      - GF_RENDERING_SERVER_URL=http://renderer:8081/render
      - GF_RENDERING_CALLBACK_URL=http://grafana:3000/
    volumes:
      - grafana_data:/var/lib/grafana
    networks:
      - grafana
    depends_on:
      - renderer
    restart: unless-stopped

  renderer:
    image: grafana/grafana-image-renderer:latest
    container_name: renderer
    ports:
      - "8081:8081"
    networks:
      - grafana
    restart: unless-stopped

  grafana-reporter:
    image: ghcr.io/notyusta/grafana-reporter
    container_name: grafana-reporter
    ports:
      - "8686:8686"
    environment:
      CMD_ENABLE: "0"                    # Jalankan dalam mode web server
      GRAFANA_HOST: "grafana:3000"
      HTTP_PORT: ":8686"
      GRAFANA_PROTO: "http://"
      GRAFANA_SSL_CHECK: "false"
    networks:
      - grafana
    restart: unless-stopped
```

7. Klik **Deploy the stack** untuk memulai proses.