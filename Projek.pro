DOMAINS
jelas = symbol
gejala = symbol
apa = string
jawab = char
penyakit = symbol
kondisi = cond*
cond = string

FACTS
kel(kondisi)
false(cond)
kangker_nasofaring(jelas)
kangker_amandel(jelas)
kangker_laring(jelas)
telinga_tersumbat(jelas)
otitis_sekretoris(jelas)
otitis_eksterna(jelas)
perinkodritis(jelas)
eksim(jelas)
search(gejala)
gagal(gejala)

PREDICATES
nondeterm login
nondeterm mulai
nondeterm selesai				
nondeterm home
nondeterm jenis	
nondeterm jelass
nondeterm akhir		
nondeterm back(char)
nondeterm next(char)
nondeterm pilih(char)
nondeterm gangguan(penyakit)
nondeterm sebab(penyakit)						
nondeterm hasil(char)	
nondeterm hasil1(char)					
nondeterm gejala(gejala)
nondeterm diagnosa(penyakit)
nondeterm solusi(penyakit)
nondeterm obat(penyakit)
nondeterm list(kondisi)
del
simpan(gejala,jawab)
tanya(apa,gejala,jawab)
lanjut
cari(apa,gejala)
failed1(apa,gejala)
potong(char,char)
wrong(char,char)



CLAUSES
	potong(Y,Y):-!.			% cut -> mencegah lacak balik
	potong(_,_):-fail.		% fail -> memaksa lacak balik

	wrong(Y,Y):-!.			% cut -> mencegah lacak balik
	wrong(_,_):-fail.		% fail -> memaksa lacak balik

			
selesai:-
	write("\t\t============== SISTEM DIAGNOSA PENYAKIT THT =============="),nl,
	write("\t============== SILAHKAN KONSULTASI MASALAH YANG ADA PADA DIRI ANDA =============="),nl,nl,
	write("SILAHKAN ISI PERTANYAAN DI BAWAH DENGAN JAWABAN Y(benar) dan N(tidak benar)"),nl,nl,
	write("Masukan nama anda : "),
	readln(Orang),
	write("Selamat datang ", Orang),nl,
	login.
			
login:-
	write("\n======================SELAMAT DATANG DI PROGRAM======================"),nl,
	write("Tekan 'Y' Untuk Memulai Program\n"),
	write("Tekan 'N' Untuk Keluar\n"),
	
	readchar(A), hasil(A).			%readchar untuk membaca karakter kalo misalkan kita tekan y
	hasil(A):-potong(A,'Y'), home.		%sehingga akan melanjutkan eksekusi ke hasil
	hasil(A):-potong(A,'y'), home.		%jika kita tekan y atau Y maka akan meneruskan eksekusi ke home
	hasil(A):-potong(A,'N'), akhir.
	hasil(A):-potong(A,'n'), akhir.
	hasil(_):-login.			%jika kita tekan sembarang maka akan kembali ke start
	

      
mulai:-
	lanjut,nl,nl,nl,
	write("Apakah Ingin mengulang lagi (Y/N) ?\n"),
	readchar(A),hasil1(A).
	hasil1(A):-potong(A,'Y'), mulai.
	hasil1(A):-potong(A,'y'), mulai.
	hasil1(A):-potong(A,'N'), home.
	hasil1(A):-potong(A,'n'), home.
	hasil1(_):-mulai.
	
	
lanjut:-
	diagnosa(_),!,
	save("test.dat"),		% menyimpan data
	del.
            
lanjut:-
	write("\n\n\MAAF PROGRAM KAMI TIDAK DAPAT MENYELESAIKAN PERMASALAHAN ANDA \nSilahkan Hubungi Dokter Spesialis Untuk Konsultasi Lebih Lanjut"),nl,
	del.
            
cari(_,Gejala):-
	write("\nApakah "),
        search(Gejala),!.
            
cari(Tanya,Gejala):-
        not(gagal(Gejala)),
        tanya(Tanya,Gejala,Jawab),
        Jawab='y'.
            
failed1(_,Gejala):-
        gagal(Gejala),!.
            
failed1(Tanya,Gejala):-
	not(search(Gejala)),
	tanya(Tanya,Gejala,Jawab),
	Jawab='n'.
            
tanya(Tanya,Gejala,Jawab):-
	write(Tanya),
	readchar(Jawab),
	write(Jawab),nl,
	simpan(Gejala,Jawab).
            
simpan(Gejala,'y'):-
 	asserta(search(Gejala)).		% untuk menambah data
            
simpan(Gejala,'n'):-
	asserta(gagal(Gejala)).
            
        del:-
retract(search(_)),fail.		% untuk menghapus data
            
del:-
        retract(gagal(_)),
        fail.
	del.

	
	
home:-	
	write("\n=========================================================================================================="),nl,
	write("\t \t \t \t MENU UTAMA\n"),nl,
	write("1. Konsultasi Gangguan THT.\n"),
	write("2. Jenis Gangguan THT.\n"),
	write("3. Penjelasan Penyakit.\n"),
	write("4. Keluar.\n"),
	write("Piihan (1-4): \n"),

	readchar(A), pilih(A).

	pilih(A):- potong(A,'1'),mulai.
	pilih(A):- potong(A,'2'),jenis.
	pilih(A):- wrong(A,'3'),jelass.
	pilih(A):- potong(A,'4'),akhir.
	pilih(_):-home.
			
						

jenis:-	
	write("\n=========================================================================================================="),nl,
	write("\t \t \t JENIS - JENIS GANGGUAN ORGAN THT\n"),nl,
	write("1. Kangker Nasofaring.\n"),
	write("2. Kangker Amandel.\n"),
	write("3. Kangker Laring.\n"),
	write("4. Telinga Tersumbat.\n"),
	write("5. Otitis Sekretoris.\n"),
	write("6. Otitis Eksterna.\n"),
	write("7. Eksim.\n"),
	write(" Tekan 'Q' untuk kembali ke menu utama\n"),

	readchar(A), next(A).
	
	
	next(A):- wrong(A,'Q'),home.
	next(A):- wrong(A,'q'),home.
	next(_):- jenis.


/*Penjelasan Sekitar penyakit*/

	kangker_nasofaring("Kangker ini sangat erat kaitannya dengan virus Epstein-Barr(EBV).\nMeskipun pada infeksi EBV umum, artinya tidak semua orang yang terinfeksi EBV akan mengembangkan kangker nasofaring.\n").
	kangker_amandel("Kangker ini bisa dideteksi dengan melihat suatu benjolan yang muncul di sekitar leher.\n karena kelenjar getah bening sudah terkena kangker tersebut.\n").
	kangker_laring("Kangker ini adalah kangker yang paling cepat berkembang biak,\n karena cepatnya muncul sel sel yang abnormal. \nPemicu pertumbuhan tersebut belum di ketahui secara pasti.\n").
	telinga_tersumbat("Penyakit ini paling sering terjadi bersamaan dengan pilek \nkarena adanya proses peradangan pada saluran napas yang masih berhubungan dengan saluran telinga.\n ").
	otitis_sekretoris("Penyakit ini biasanya menyerang anak anak karena memiliki tuba estakius yang lebih pendek, \nlebih sempit dan posisinya lebih mendatar.\n").
	otitis_eksterna("adalah peradangan saluran telinga bagian luar (lubang telinga luar sampai gendang telinga).\n Apabila anda menderita otitis eksterna disertai jerawat sebaiknya jangan memencetnya.\n karena dikhawatirkan bisa membuat infeksi menyebar\n").
	perinkodritis("Merupakan suatu radang yang menyerang pada salah satu bagian telinga dan titik penyerangannya pada daun telinga.\n").
	eksim("Penyakit ini sebenarnya adalah penyakit kulit, tetapi dalam penyebarannya biasanya sering terjadi di bagian teling.\n").
	
jelass:-
	write("\n=========================================================================================================="),nl,
	write("\t \t PENJELASAN DARI PENYAKIT\n"),nl,nl,
	kangker_nasofaring(Nasofaring),
	write("Kangker Nasofaring		: ",Nasofaring),nl,

	kangker_amandel(Amandel),
	write("Kangker Amandel		: ",Amandel),nl,

	kangker_laring(Laring),
	write("Kangker Laring		: ",Laring),nl,

	telinga_tersumbat(Sumbat),
	write("Telinga Tersumbat		: ",Sumbat),nl,
	
	otitis_sekretoris(Sekre),
	write("Otitis Sekretoris		: ",Sekre),nl,
	
	otitis_eksterna(Eks),
	write("Otitis eksterna		: ",Eks),nl,
	
	perinkodritis(Perin),
	write("Perinkodritis		: ",Perin),nl,
	
	eksim(Sim),
	write("Eksim		: ",Sim),nl,
	
	write(" Tekan 'Q' untuk kembali ke menu utama.\n"),

	readchar(A), back(A).

	back(A):- wrong(A,'Q'),home.
	back(A):- wrong(A,'q'),home.
	back(_):- jelass.
	
	
/* Gejala gejala penyakit */

gejala(Gejala):-    
	search(Gejala),!.
                        
gejala(Gejala):-
	gagal(Gejala),!,fail.

gejala(kangker_nasofaring):-
        write("\n=========================================================================================================="),
        cari(" Apakah hidung anda tersumbat (y/t) ?", kangker_nasofaring),
	cari(" Apakah hidung anda mengeluarkan nanah (y/t) ?", kangker_nasofaring1),
	cari(" Apakah terdapat benjolan di leher (y/t) ?", kangker_nasofaring2).

gejala(kangker_amandel):-
        write("\n=========================================================================================================="),
        cari(" Apakah terdapat benjolan di leher (y/t) ?", kangker_amandel),
	cari(" Apakah tangan anda terasa nyeri (y/t) ?", kangker_amandel1).
                        
gejala(kangker_laring):-
        write("\n=========================================================================================================="),
        cari(" Apakah tangan anda terasa nyeri (y/t) ?", kangker_laring),
	cari(" Apakah leher anda terasa nyeri (y/t) ?", kangker_laring1),
	cari(" Apakah anda batuk bat akhir akhir ini (y/t) ?", kangker_laring2),
	cari(" Apakah batuk anda terkadang ukmengeluarkan darah (y/t) ?", kangker_laring3),
	cari(" Apakah saat anda bernafas terdapat bunyi sesuatu (y/t) ?", kangker_laring4),
	cari(" Apakah disaat anda menelan makanan terasa sakit (y/t) ?", kangker_laring5).
                        
gejala(sumbat_telinga):-
	cari(" Apakah pendengaran anda sedikit berkurang (y/t) ?", sumbat_telinga),
	cari(" Apakah telinga anda sering terasa gatal (y/t) ?", sumbat_telinga1).
		
		
gejala(otitis_sekretoris):-
	cari(" Apakah pendengaran anda sedikit berkurang (y/t) ?", otitis_sekretoris),
	cari(" Apakah telinga anda terasa penuh (y/t) ?", otitis_sekretoris1).
	
gejala(otitis_eksterna):-
	cari(" Apakah pendengaran anda sedikit berkurang (y/t) ?", otitis_eksterna),
	cari(" Apakah telinga anda terasa gatal (y/t) ?", otitis_eksterna1),
	cari(" Apakah pada saat telinga anda gatal di sertai juga dengan terasa nyeri (y/t) ?", otitis_eksterna2),
	cari(" Apakah telinga anda keluar cairan berbau (y/t) ?", otitis_eksterna3).

gejala(perinkondritis):-
	cari(" Apakah daun telinga anda terasa bengkak (y/t) ?", perikondritis),
	cari(" Apakah daun telinga anda bewarna merah (y/t) ?", perikondritis1).
	
gejala(eksim):-
	cari(" Apakah telinga anda terasa gatal (y/t) ?", eksim),
	cari(" Apakah telinga anda keluar cairan berbau (y/t) ?", eksim1),
	cari(" Apakah daun telinga anda bewarna merah ?", eksim2).
                        


/*Diagnosa*/

diagnosa("kangker_nasofaring"):-
	gejala(kangker_nasofaring),
	gejala(kangker_nasofaring1),
	gejala(kangker_nasofaring2),
	gangguan("Anda mengalami gangguan Kangker Nasofaring\n"),
	sebab("\n 1.Laki laki \n 2.Usia dibawah 55 tahun \n 3.Sering makan makanan asin \n 4.Memiliki riwayat keluarga kangker nesofaring \n 5.Perokok Aktif \n 6.Peminum Alkohol \n 7.Terpapar debu atau bahan kimia yang mengandung formaldehid \n"),
	solusi("\n 1.Terapi radiasi (Pengobatan standar awal) \n 2.Operasi atau Pembedahan \n 3.Obat obat biologis \n 4.Kemoterapi \n"),
	obat("\n 1.Makan makanan yang kaya akan buah buahan dan sayur sayuran. \n 2.Hindari ikan asin dan makanan yang kadar garam tinggi lainnya \n 3.Jangan Merokok \n 4.Jangan minum alkohol berlebihan \n").
		
                        
diagnosa("kangker_amandel"):-
	gejala(kangker_amandel),
	gejala(kangker_amandel1),
	gangguan("Anda mengalami gangguan Kangker Amandel\n"),
	sebab("\n 1.Laki laki \n 2.Usia sekitar 50 - 70 tahun \n 3.Temuan baru bisa disebabkan oleh virus HPV \n  4.Perokok Aktif \n 5.Peminum Alkohol \n"),
	solusi("\n 1.Terapi radiasi (Penyinaran) \n 2.Operasi atau Pembedahan \n"),
	obat("\n 1.Jangan Merokok \n 2.Jangan minum alkohol berlebihan \n 3.Jaga pola makan teratur dan makan makanan mengandung serat \n").
            

diagnosa("kangker_laring"):-
	gejala(kangker_laring),
	gejala(kangker_laring1),
	gejala(kangker_laring2),
	gejala(kangker_laring3),
	gejala(kangker_laring4),
	gejala(kangker_laring5),
	gangguan("Anda mengalami gangguan Kangker Laring\n"),
	sebab("\n 1.Perokok Aktif \n 2.Peminum Alkohol \n 3.Terpapar debu atau bahan kimia tertentu dalam jangka panjang misalnya debu asbes \n 4.Memiliki riwayat keluarga mengidap kangker pada bagian kepala atau leher \n"),
	solusi("\n 1.Kemoterapi \n 2.Radioterapi \n 3.Operasi \n"),
	obat("\n 1.Jangan Merokok \n 2.Jangan minum alkohol berlebihan \n 3.Jaga pola makan teratur \n").
		

diagnosa("sumbat_telinga"):-
	gejala(sumbat_telinga),
	gejala(sumbat_telinga1),
	gangguan("Telinga Anda tersumbat\n"),
	sebab("\n 1.Kotoran menumpuk di telinga \n 2.Pilek \n 3.Kemasukan air \n"),
	solusi("\n 1.Menyemprotkan obat telinga dari air garam untuk membantu mengencerkan kotoran \n 2.Hindari suhu ekstrim \n"),
	obat("\n 1.Rajin rajin membersihkan kotoran di telinga \n 2.3.Jaga pola makan teratur pada saat cuaca ekstrim agar tidak pilek \n").

diagnosa("otitis_sekretoris"):-
	gejala(otitis_sekretoris),
	gejala(otitis_sekretoris1),
	gangguan("Anda mengalami gangguan Ototitis sekretoris\n"),
	sebab("\n Penyumbatan tuba estakius atau jenis saluran yang menghubungkan telinga tengah dengan hidung bagian belakang dengan tenggorokan \n"),
	solusi("\n Pemberian antibiotik dan obat lainnya yaitu fenilefrin, efedrin dan antihistamin \n"),
	obat("\n Tidak Ada \n").

diagnosa("otitis_eksterna"):-
	gejala(otitis_eksterna),
	gejala(otitis_eksterna1),
	gejala(otitis_eksterna2),
	gejala(otitis_eksterna3),
	gangguan("Anda mengalami gangguan Ototitis Eksterna\n"),
	sebab("\n 1. Bakteri, Jamur dan Virus \n 2.Remah remah yang berasal dari luar misalnya pasir \n 3.Terlalu sering membersihkan telinga \n 4.Efek samping alat bantu dengar \n"),
	solusi("\n Pemberian obat tetes telinga \n"),
	obat("\n 1.Jaga telinga tetap bersih dan kering \n 2.Hindari terjadinya luka di dalam telinga anda \n").

diagnosa("perinkondritis"):-
	gejala(perinkondritis),
	gejala(perinkondritis1),
	gangguan("Anda mengalami gangguan Perinkodritis\n"),
	sebab("\n 1.Cedera \n 2.Gigitan serangga \n 3.Pemecahan bisul dengan sengaja \n 4.Radang yang menyerang tulang daun telinga \n 5.Adanya suatu memar tanpa adanya hematoma \n"),
	solusi("\n 1.Pengompresan pada telinga \n 2.Pengobatan dengan trobamisin dan tikarsilin yang di berikan bersama-sama \n 3.Dilakukan insisi secara steril dan di beri perban tekan selama 48 jam seperti pada hematoma daun telinga. \n"),
	obat("\n 1.Menjalankan pola hidup yang sehat \n 2.Membuang nanah bisul dengan cara di beri sayatan terlebih dahulu \n").

diagnosa("eksim"):-
	gejala(eksim),
	gejala(eksim1),
	gejala(eksim2),
	gangguan("Anda mengalami gangguan Eksim\n"),
	sebab("\n 1.Alergi dalam penggunaan kosmetik kulit \n 2.Kurangnya menjaga kebersihan badan (mandi) \n"),
	solusi("\n Pemberian obat antihistamin \n"),
	obat("\n 1.Hati-hati dalam menggunakan atribut tubuh seperti kosmetik dan baju \n 2.Rajin rajinlah mandi \n").

gangguan(Penyakit):-
	write("\n=========================================================================================================="),
	write("\nGangguan yang anda alami : ",Penyakit).


sebab(Penyakit):-
	write("\nPenyebab : ",Penyakit).

solusi(Penyakit):-
	write("\nPenanganan : ",Penyakit).

obat(Penyakit):-
	write("\nPencegahan : ",Penyakit),
	write("\n==========================================================================================================").
	
akhir:-
	write("|==================================******************************=================================|"),
	write("\n|     	  	   TERIMA KASIH, ANDA TELAH MENGGUNAKAN PROGRAM KAMI			   |\n"),					    	
	write("|_________________________________________________________________________________________|\n"),
	write("Nama Anggota Kelompok	: "),nl,
	kel(Kelompok),
	list(Kelompok),
	login.


kel(["1. R.H Kimebmen S				1515015",		%isi list
	"2. M. Rezky F				1515015",
	"3. Bambang P				1515015168"]).
	
list([H|T]):-
	not(false(H)),
	write(H),nl,
	list(T).
	
list([H|_]):-
	assertz(false(H)).

GOAL
selesai.