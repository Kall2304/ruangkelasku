/// Semua teks UI. Label navigasi mengikuti Google Classroom versi Indonesia.
/// Tanpa tanda pisah panjang (docs/design.md, bagian Teks UI).
abstract final class S {
  // Aplikasi
  static const appName = 'RuangKelasku';

  // Umum
  static const retry = 'Coba lagi';
  static const cancel = 'Batal';
  static const save = 'Simpan';
  static const close = 'Tutup';
  static const done = 'Selesai';
  static const more = 'Opsi lainnya';
  static const copy = 'Salin';
  static const copied = 'Disalin';
  static const loadMore = 'Muat lainnya';
  static const required = 'Wajib diisi';
  static const errorGeneric = 'Terjadi kesalahan. Coba lagi sebentar lagi.';
  static const errorNetwork = 'Hmm, koneksinya putus. Periksa internet atau server, lalu coba lagi.';
  static const errorNotFound = 'Data tidak ditemukan atau sudah dihapus.';
  static const justNow = 'Baru saja';
  static const yesterday = 'Kemarin';
  static String minutesAgo(int n) => '$n menit lalu';
  static String hoursAgo(int n) => '$n jam lalu';
  static String dueAt(String date) => 'Tenggat $date';

  // Sambutan dan autentikasi
  static const welcomeTitle = 'Hai! Selamat datang di RuangKelasku.';
  static const welcomeBody = 'Satu tempat untuk materi, tugas, dan nilai. Masuk atau buat akun untuk mulai.';
  static const signIn = 'Masuk';
  static const signUp = 'Buat akun';
  static const signOut = 'Keluar';
  static const name = 'Nama lengkap';
  static const email = 'Email';
  static const password = 'Kata sandi';
  static const passwordConfirm = 'Ulangi kata sandi';
  static const showPassword = 'Tampilkan kata sandi';
  static const hidePassword = 'Sembunyikan kata sandi';
  static const passwordHint = 'Minimal 8 karakter';
  static const passwordMismatch = 'Kata sandi tidak sama';
  static const invalidEmail = 'Format email tidak valid';
  static const noAccount = 'Belum punya akun?';
  static const haveAccount = 'Sudah punya akun?';
  static const signedInAs = 'Anda saat ini login sebagai';

  // Navigasi global
  static const navClasses = 'Kelas';
  static const navTodo = 'Daftar tugas';
  static const navToReview = 'Perlu diperiksa';
  static const navNotifications = 'Notifikasi';
  static const navArchived = 'Kelas yang diarsipkan';
  static const navSettings = 'Setelan';
  static const openMenu = 'Buka menu navigasi';
  static const addClass = 'Gabung atau buat kelas';

  // Beranda
  static const joinClass = 'Gabung ke kelas';
  static const createClass = 'Buat kelas';
  static const emptyClasses = 'Belum ada kelas. Gabung pakai kode dari gurumu, yuk.';
  static const invitationsTitle = 'Undangan kelas';
  static String invitedAs(String inviter, bool asTeacher) =>
      '$inviter mengundang Anda sebagai ${asTeacher ? 'pengajar' : 'siswa'}';
  static const accept = 'Terima';
  static const decline = 'Tolak';
  static String studentCount(int n) => '$n siswa';
  static String openClass(String name) => 'Buka kelas $name';

  // Gabung ke kelas
  static const classCode = 'Kode kelas';
  static const classCodeHelp = 'Mintalah kode kelas kepada pengajar, lalu masukkan kode di sini.';
  static const classCodeRules = 'Kode kelas terdiri dari 5 sampai 8 huruf atau angka, tanpa spasi atau simbol.';
  static const join = 'Gabung';
  static String joinedTitle(String name) => 'Hore, kamu sudah bergabung di $name!';
  static const openClassButton = 'Buka kelas';

  // Buat kelas
  static const className = 'Nama kelas (wajib)';
  static const section = 'Bagian';
  static const subject = 'Mata pelajaran';
  static const room = 'Ruang';
  static const theme = 'Tema';
  static const create = 'Buat';
  static const themeNames = {
    'forest': 'Hutan',
    'ocean': 'Samudra',
    'sunset': 'Senja',
    'grape': 'Anggur',
    'rose': 'Mawar',
    'lagoon': 'Laguna',
    'mango': 'Mangga',
    'slate': 'Batu',
  };

  // Menu kartu kelas dan kelas terarsip
  static const archive = 'Arsipkan';
  static const restore = 'Pulihkan';
  static const delete = 'Hapus';
  static const leaveClass = 'Batalkan pendaftaran';
  static const emptyArchived = 'Tidak ada kelas yang diarsipkan.';
  static String archiveTitle(String name) => 'Arsipkan $name?';
  static const archiveBody =
      'Kelas yang diarsipkan menjadi baca-saja: tidak ada posting, penyerahan, atau penilaian baru. Anda bisa memulihkannya kapan saja.';
  static String deleteTitle(String name) => 'Hapus $name?';
  static const deleteBody = 'Kelas ini dan semua isinya tidak akan bisa diakses lagi.';
  static String leaveTitle(String name) => 'Batalkan pendaftaran dari $name?';
  static const leaveBody = 'Anda akan dikeluarkan dari kelas ini dan tugas Anda di kelas ini ikut terhapus.';
  static const archived = 'Kelas diarsipkan';
  static const restored = 'Kelas dipulihkan';

  // Tab kelas
  static const tabStream = 'Forum';
  static const tabClasswork = 'Tugas Kelas';
  static const tabPeople = 'Anggota';
  static const tabGrades = 'Nilai';
  static const tabMyWork = 'Tugas Anda';
  static const classSettings = 'Setelan kelas';
  static const showClassCode = 'Tampilkan kode kelas';
  static const comingSoon = 'Layar ini sedang disiapkan.';
  static const archivedBanner = 'Kelas ini diarsipkan. Semua isinya hanya bisa dibaca.';
  static const backToClasses = 'Kembali ke daftar kelas';

  // Forum
  static const shareWithClass = 'Bagikan dengan kelas Anda';
  static const announceHint = 'Umumkan sesuatu kepada kelas Anda';
  static const upcoming = 'Mendatang';
  static const upcomingEmpty = 'Tidak ada tugas yang perlu segera diselesaikan.';
  static const emptyStream = 'Belum ada posting. Di sinilah pengumuman dan tugas baru akan muncul.';
  static const seeMore = 'Lihat selengkapnya';
  static String commentCount(int n) => n == 1 ? '1 komentar kelas' : '$n komentar kelas';
  static String postedNew(String author, String type, String title) =>
      '$author memposting ${type.toLowerCase()} baru: $title';
  static const postTypeNames = {
    'announcement': 'Pengumuman',
    'material': 'Materi',
    'assignment': 'Tugas',
    'quiz': 'Tugas kuis',
    'question': 'Pertanyaan',
  };
  static const post = 'Posting';
  static const removeSchedule = 'Hapus jadwal';
  static const openAttachment = 'Buka lampiran';
  static const schedule = 'Jadwalkan';
  static const scheduledFor = 'Dijadwalkan untuk';
  static const pickDate = 'Pilih tanggal';
  static const pickTime = 'Pilih jam';
  static const posted = 'Diposting';
  static const scheduled = 'Terjadwal';
  static String scheduledAt(String date) => 'Terjadwal $date';
  static const announcementPosted = 'Pengumuman diposting';
  static const announcementScheduled = 'Pengumuman dijadwalkan';
  static const discardTitle = 'Buang perubahan?';
  static const discardBody = 'Teks yang sudah Anda tulis akan hilang.';
  static const discard = 'Buang';
  static const keepEditing = 'Lanjut menulis';

  // Anggota
  static const teachers = 'Pengajar';
  static const students = 'Siswa';
  static const inviteTeacher = 'Undang pengajar';
  static const inviteStudent = 'Undang siswa';
  static const invite = 'Undang';
  static const inviteEmailHelp = 'Undangan muncul di beranda pengguna dengan email ini.';
  static const invitationSent = 'Undangan dikirim';
  static const owner = 'Pemilik kelas';
  static const remove = 'Keluarkan';
  static String removeTitle(String name) => 'Keluarkan $name?';
  static const removeStudentBody =
      'Siswa ini kehilangan akses ke kelas, dan semua tugasnya di kelas ini ikut terhapus.';
  static const removeTeacherBody = 'Pengajar ini kehilangan akses ke kelas.';
  static const noStudents = 'Belum ada siswa. Bagikan kode kelas atau undang siswa lewat email.';
  static String memberCount(int n) => '$n orang';
  static const pendingInvitations = 'Undangan tertunda';
  static const cancelInvitation = 'Batalkan undangan';
  static String invitePageTitle(bool teacher) => teacher ? inviteTeacher : inviteStudent;

  // Status submission
  static const statusLabels = {
    'assigned': 'Ditugaskan',
    'missing': 'Tidak diserahkan',
    'turned_in': 'Diserahkan',
    'graded': 'Dinilai (draf)',
    'returned': 'Dikembalikan',
  };
  static const late = 'Terlambat';

  // Pembaca layar
  static String unreadNotifications(int n) =>
      n == 0 ? 'Tidak ada notifikasi belum dibaca' : '$n notifikasi belum dibaca';
  static String avatarOf(String name) => 'Foto profil $name';
}
