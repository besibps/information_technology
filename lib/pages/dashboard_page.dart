import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard ERP')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // Statistik Utama (diperluas)
            Row(
              children: <Widget>[
                Expanded(
                  child: _buildInfoCard(
                    'Total Penjualan',
                    'Rp 1.2M',
                    Icons.attach_money,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildInfoCard(
                    'Pesanan Baru',
                    '25',
                    Icons.shopping_cart,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildInfoCard(
                    'Work Order Aktif',
                    '15',
                    Icons.assignment,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: <Widget>[
                Expanded(
                  child: _buildInfoCard(
                    'Stok Rendah',
                    '8 Item',
                    Icons.inventory,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildInfoCard(
                    'Purchase Request Baru',
                    '10',
                    Icons.playlist_add,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildInfoCard(
                    'Purchase Receipt Baru',
                    '5',
                    Icons.receipt,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Grafik-grafik
            const Text(
              'Analisis',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Row(
              children: <Widget>[
                Expanded(child: _buildChartPlaceholder('Penjualan Bulanan')),
                const SizedBox(width: 16),
                Expanded(child: _buildChartPlaceholder('Status Work Order')),
              ],
            ),
            const SizedBox(height: 24),

            // Daftar Terbaru (diperluas)
            const Text(
              'Aktivitas Terbaru',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            _buildRecentActivity(),

            const SizedBox(height: 24),

            // Pengumuman & Tugas
            Row(
              children: <Widget>[
                Expanded(child: _buildAnnouncements()),
                const SizedBox(width: 16),
                Expanded(child: _buildTaskList()),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(String title, String value, IconData icon) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 8),
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text(value, style: const TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }

  Widget _buildChartPlaceholder(String title) {
    return SizedBox(
      height: 180,
      child: Card(
        elevation: 2,
        child: Center(
          child: Text(
            'Grafik $title di sini',
          ), // Anda akan mengganti ini dengan widget grafik
        ),
      ),
    );
  }

  Widget _buildRecentActivity() {
    return Card(
      elevation: 2,
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 5, // Contoh 5 aktivitas terbaru
        separatorBuilder: (context, index) => const Divider(),
        itemBuilder: (context, index) {
          String activity;
          IconData icon;
          switch (index) {
            case 0:
              activity = 'Pesanan #201 diterima';
              icon = Icons.shopping_cart_checkout;
              break;
            case 1:
              activity = 'Work Order #118 diperbarui';
              icon = Icons.assignment;
              break;
            case 2:
              activity = 'Stok untuk Item A menipis';
              icon = Icons.inventory;
              break;
            case 3:
              activity = 'Purchase Request #3 disetujui';
              icon = Icons.playlist_add_check;
              break;
            case 4:
              activity = 'Penerimaan Barang #7 tercatat';
              icon = Icons.receipt;
              break;
            default:
              activity = 'Aktivitas Lain';
              icon = Icons.timeline;
          }
          return ListTile(
            leading: Icon(icon),
            title: Text(activity),
            subtitle: const Text('Beberapa waktu lalu'),
            onTap: () {
              // Navigasi ke detail
            },
          );
        },
      ),
    );
  }

  Widget _buildAnnouncements() {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const <Widget>[
            Text(
              'Pengumuman',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            SizedBox(height: 8),
            Text(
              'Rapat tim akan diadakan besok pukul 10:00 di ruang meeting utama.',
            ),
            SizedBox(height: 8),
            Text(
              'Pastikan semua laporan penjualan bulanan sudah disubmit hari ini.',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTaskList() {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Tugas Saya',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 8),
            _buildTaskItem('Tindak lanjuti WO #115'),
            _buildTaskItem('Verifikasi Purchase Request #4'),
            _buildTaskItem('Update data inventaris'),
          ],
        ),
      ),
    );
  }

  Widget _buildTaskItem(String task) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: <Widget>[
          const Icon(Icons.check_box_outline_blank),
          const SizedBox(width: 8),
          Text(task),
        ],
      ),
    );
  }
}
