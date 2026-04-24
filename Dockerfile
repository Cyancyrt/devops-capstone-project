FROM python:3.9-slim

# Membuat folder kerja dan menginstal dependensi
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Menyalin isi paket service ke dalam image
COPY service/ ./service/

# Beralih ke user non-root (untuk keamanan)
RUN useradd --uid 1000 theia && chown -R theia /app
USER theia

# Menjalankan layanan menggunakan Gunicorn
EXPOSE 8080
CMD ["gunicorn", "--bind=0.0.0.0:8080", "--log-level=info", "service:app"]
