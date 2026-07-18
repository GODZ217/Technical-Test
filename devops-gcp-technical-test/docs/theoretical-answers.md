# Jawaban Teori

## 1. Apa perbedaan utama antara Cloud Run, Compute Engine, dan GKE di GCP? Kapan Anda akan memilih masing-masing?

Cloud Run adalah layanan serverless untuk menjalankan aplikasi berbasis container tanpa perlu mengelola server. Compute Engine adalah Virtual Machine (VM) yang memberikan kontrol penuh terhadap sistem operasi dan konfigurasi server. GKE adalah layanan Kubernetes yang digunakan untuk mengelola banyak container dengan kebutuhan orkestrasi yang lebih kompleks. Saya memilih Cloud Run untuk API atau microservice yang membutuhkan autoscaling dengan pengelolaan minimal. Compute Engine cocok untuk aplikasi legacy atau yang membutuhkan akses penuh ke sistem operasi, sedangkan GKE digunakan ketika aplikasi terdiri dari banyak service dan membutuhkan pengelolaan container dalam skala besar.

## 2. Jelaskan konsep Infrastructure as Code (IaC) dan manfaat utamanya.

Infrastructure as Code (IaC) adalah cara mengelola infrastruktur menggunakan kode sehingga proses provisioning dapat dilakukan secara otomatis dan konsisten. Dengan IaC, konfigurasi infrastruktur dapat disimpan di Git sehingga perubahan lebih mudah dilacak dan direview. Pendekatan ini juga mengurangi human error karena tidak perlu membuat resource secara manual. Selain itu, proses deployment atau rebuild environment menjadi lebih cepat dan mudah diulang kapan saja.

## 3. Bagaimana Anda mengatur IAM Role & Policy agar proses CI/CD di GCP tetap aman?

Saya menerapkan prinsip least privilege, yaitu setiap user atau service account hanya diberikan akses sesuai kebutuhannya. Pipeline CI/CD menggunakan service account khusus, bukan akun pribadi. Role yang diberikan hanya sebatas kebutuhan deploy, misalnya ke Cloud Run dan Artifact Registry. Credential disimpan di GitHub Secrets atau Google Secret Manager, bukan di repository. Dengan cara ini, risiko penyalahgunaan akses dapat dikurangi.

## 4. Jika aplikasi di Cloud Run sering mengalami lonjakan latency saat autoscaling, langkah troubleshooting apa yang akan Anda lakukan?

Saya akan memeriksa metric di Cloud Monitoring untuk mengetahui apakah latency disebabkan oleh cold start, resource yang kurang, atau bottleneck pada database. Jika cold start menjadi penyebab utama, saya akan mempertimbangkan penggunaan minimum instances. Saya juga akan mengevaluasi alokasi CPU dan memory serta memastikan koneksi ke Cloud SQL atau service lain tidak menjadi hambatan. Terakhir, saya akan memeriksa Cloud Logging untuk mencari error, timeout, atau request yang berjalan lebih lambat dari biasanya.

## 5. Apa perbedaan monitoring dan logging? Bagaimana Anda mengintegrasikan keduanya di GCP?

Monitoring digunakan untuk memantau kondisi aplikasi melalui metric seperti CPU, memory, response time, dan availability. Logging digunakan untuk mencatat detail aktivitas aplikasi seperti error, request, atau exception. Di GCP, saya menggunakan Cloud Monitoring untuk dashboard dan alert, sedangkan Cloud Logging untuk analisis log. Monitoring membantu mengetahui kapan masalah terjadi, sementara logging membantu menemukan penyebabnya.

# Studi Kasus Troubleshooting

## Quick Win

Karena memory leak belum bisa diperbaiki dalam waktu dekat, fokus saya adalah menjaga aplikasi tetap berjalan. Saya akan meningkatkan kapasitas memory jika memungkinkan, mengaktifkan auto restart ketika aplikasi crash, serta membuat alert penggunaan memory di Cloud Monitoring. Jika aplikasi melayani trafik tinggi, saya juga akan menjalankan beberapa VM di belakang Load Balancer agar layanan tetap tersedia ketika salah satu instance bermasalah.

## Solusi Jangka Panjang

Solusi utama adalah memperbaiki memory leak pada aplikasi melalui profiling dan perbaikan kode oleh tim developer. Setelah diperbaiki, saya akan melakukan load test untuk memastikan penggunaan memory tetap stabil. Saya juga akan memperkuat monitoring dan alert agar masalah serupa dapat dideteksi lebih awal. Jika memungkinkan, saya akan mengevaluasi penggunaan platform yang lebih mudah diskalakan seperti Cloud Run atau GKE.
