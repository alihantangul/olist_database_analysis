# Olist Veritabanı Analizi

![Olist veri modeli](olist_entity.svg)

Bu proje, Olist'in Ekim 2016-Ekim 2018 dönemindeki yaklaşık 100 bin e-ticaret siparişini PostgreSQL ve SQL-first notebook'larla inceler. Filtreleme, birleştirme, gruplama, korelasyon ve regresyon hesapları SQL'de yapılır; Python yalnızca sorgu sonuçlarını göstermek ve grafik üretmek için kullanılır.

## Proje Yapısı

| Analiz | Notebook |
|---|---|
| Sipariş sıklığı ve teslimat | [Frequency Analysis](Frequency_analysis_of_orders/Frequency_analysis_of_orders.ipynb) |
| Müşteri analizi | [Customer Analysis](Customer_analysis/Customer_analysis.ipynb) |
| Satıcı analizi | [Seller Analysis](Seller_analysis/Seller_analysis.ipynb) |
| Ürün analizi | [Product Analysis](Product_analysis/Product_Analysis.ipynb) |
| Tamamlayıcı analizler | [Miscellaneous](Miscellaneous/Miscellaneous.ipynb) |
| Grafikler ve veri hikâyesi | [Visualizations](Visualizations/olist_visualizations.ipynb) |

## Kurulum

1. Repoyu klonlayın ve klasöre geçin.
2. Python bağımlılıklarını kurun:

   ```bash
   pip install -r requirements.txt
   ```

3. Olist CSV dosyalarını `olist_data/` klasörüne indirin. CSV dosyaları boyut ve lisans nedeniyle Git'e eklenmez.
4. PostgreSQL'de `olist` veritabanını oluşturun.
5. Repo kökünde aşağıdaki komutları çalıştırın:

   ```bash
   psql -U postgres -d olist -f create_table.sql
   psql -U postgres -d olist -f import_data.sql
   ```

   `import_data.sql`, repo kökünden çalıştırıldığında `olist_data/` altındaki dosyaları bulur.

6. Ortam dosyasını oluşturun:

   ```bash
   cp .env.example .env
   ```

7. `.env` içindeki bağlantı bilgilerini kendi PostgreSQL kurulumunuza göre düzenleyin:

   ```dotenv
   OLIST_DB_HOST=localhost
   OLIST_DB_NAME=olist
   OLIST_DB_USER=postgres
   OLIST_DB_PASSWORD=your_password
   ```

8. Jupyter'ı başlatın:

   ```bash
   jupyter notebook
   ```

Gerçek `.env` dosyası ve CSV dosyaları `.gitignore` ile Git dışında tutulur.

## Şema Adlandırması

Notebook'lar ve kurulum SQL'leri aynı kısa isimleri kullanır. Örnekler:

| CSV başlığı | PostgreSQL kolonu |
|---|---|
| `product_category_name` | `product_category` |
| `product_weight_g` | `product_weight_grams` |
| `order_purchase_timestamp` | `order_purchase` |
| `order_delivered_customer_date` | `order_delivered_customer` |
| `review_comment_message` | `review_comment` |

Mevcut Kaggle adlarıyla kurulmuş bir veritabanını bu şemaya geçirmek için `migrate_schema_to_repo_names.sql` kullanılabilir. Migration yalnızca tablo/kolon adlarını ve eksik anahtarları düzenler; analiz verisini silmez.

## Öne Çıkan Bulgular

- 99.441 siparişin 96.478'i teslim edilmiştir; teslim oranı `%97,02`'dir.
- Teslim edilen siparişlerde en yüksek aylık hacim Kasım 2017'de 7.289 sipariş ve 1.153.528,05 ödeme değeriyle görülmüştür.
- `health_beauty`, 9.465 ürün kalemi ve 1.233.131,72 ürün geliriyle en yüksek gelirli kategoridir.
- Ortalama teslimat süresi SP eyaletinde 8,76 gün, RR eyaletinde 29,39 gündür. RR sonucu yalnızca 41 siparişe dayandığı için hacim farkı dikkate alınmalıdır.
- Kredi kartı, 76.795 işlem ve 12.542.084,19 toplam ödeme değeriyle en yüksek hacimli ödeme yöntemidir.

Bu bulgular betimleyicidir. Korelasyon ve regresyon sonuçları nedensellik kanıtı olarak yorumlanmamalıdır.

## Veri Kaynağı

Veri seti: [Brazilian E-Commerce Public Dataset by Olist](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce)
