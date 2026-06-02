import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import '../../theme/app_theme.dart';
import '../../widgets/glass_card.dart';

class EcdPlayScreen extends StatefulWidget {
  final String category; // 'stories', 'folktales', 'spelling'
  const EcdPlayScreen({super.key, required this.category});

  @override
  State<EcdPlayScreen> createState() => _EcdPlayScreenState();
}

class _EcdPlayScreenState extends State<EcdPlayScreen> {
  final FlutterTts flutterTts = FlutterTts();
  bool _isPlaying = false;
  String _currentText = '';
  String _selectedLanguage = 'English'; // English, Shona, Ndebele

  @override
  void initState() {
    super.initState();
    _initTts();
  }

  Future<void> _initTts() async {
    await flutterTts.setLanguage("en-ZA");
    await flutterTts.setSpeechRate(0.35); // Slower, clearer speed for toddlers
    await flutterTts.setVolume(1.0);
    await flutterTts.setPitch(1.2); // Slightly higher, friendly pitch for kids

    flutterTts.setCompletionHandler(() {
      setState(() {
        _isPlaying = false;
      });
    });
  }

  @override
  void dispose() {
    flutterTts.stop();
    super.dispose();
  }

  Future<void> _speak(String text) async {
    if (_isPlaying && _currentText == text) {
      await flutterTts.stop();
      setState(() {
        _isPlaying = false;
      });
      return;
    }
    
    setState(() {
      _isPlaying = true;
      _currentText = text;
    });
    
    await flutterTts.speak(text);
  }

  @override
  Widget build(BuildContext context) {
    String title = '';
    IconData icon = Icons.extension;
    Color color = AppTheme.gold;

    if (widget.category == 'folktales') {
      title = 'Listen & Learn: Folk Tales';
      icon = Icons.record_voice_over;
      color = Colors.lightBlueAccent;
    } else if (widget.category == 'spelling') {
      title = 'Spelling & Pronunciation';
      icon = Icons.spellcheck;
      color = Colors.orangeAccent;
    } else {
      title = 'Story Books';
      icon = Icons.menu_book_rounded;
      color = Colors.pinkAccent;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: color.withValues(alpha: 0.2),
        actions: [
          DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: _selectedLanguage,
              dropdownColor: AppTheme.surfaceDark,
              icon: const Icon(Icons.language, color: AppTheme.gold),
              style: const TextStyle(color: AppTheme.gold, fontWeight: FontWeight.bold),
              items: ['English', 'Shona', 'Ndebele'].map((String lang) {
                return DropdownMenuItem<String>(
                  value: lang,
                  child: Text(lang),
                );
              }).toList(),
              onChanged: (String? newValue) {
                if (newValue != null) {
                  setState(() {
                    _selectedLanguage = newValue;
                    if (_isPlaying) flutterTts.stop();
                    _isPlaying = false;
                  });
                }
              },
            ),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(gradient: AppTheme.splashGradient),
        padding: const EdgeInsets.all(16),
        child: _buildContent(),
      ),
    );
  }

  Widget _buildContent() {
    if (widget.category == 'folktales') {
      if (_selectedLanguage == 'Shona') {
        return ListView(
          children: [
            _buildPlayCard('Tsuro na Gudo', 'Kare kare, Tsuro akanyengedza Gudo akatora mbambaira dzake dzose. Tsuro akafara zvikuru!', Colors.lightBlueAccent),
            const SizedBox(height: 16),
            _buildPlayCard('Shumba ne Mbeva', 'Mbeva diki yakabatsira Shumba huru nekuruma mumbure wemuvhimi. Chero shamwari diki inogona kubatsira zvakakura.', Colors.purpleAccent),
          ],
        );
      } else if (_selectedLanguage == 'Ndebele') {
        return ListView(
          children: [
            _buildPlayCard('Uvundla lo Ndwangu', 'Kudala, uVundla okhaliphileyo wakhohlisa uNdwangu wathatha amagwili akhe wonke. UVundla wathaba kakhulu!', Colors.lightBlueAccent),
            const SizedBox(height: 16),
            _buildPlayCard('Isilwane le Gundan', 'Igundan elincane lancedisa isilwane esikhulu ngokuluma inethi yomzingeli. Lomngane omncane angenza into enkulu.', Colors.purpleAccent),
          ],
        );
      } else {
        return ListView(
          children: [
            _buildPlayCard('Tsuro and Gudo', 'Once upon a time, the clever hare Tsuro tricked the baboon Gudo into giving him all the sweet potatoes. Tsuro was very happy!', Colors.lightBlueAccent),
            const SizedBox(height: 16),
            _buildPlayCard('The Lion and the Mouse', 'A little mouse saved a big strong lion by chewing through the hunter\'s net. Even the smallest friends can be a big help.', Colors.purpleAccent),
          ],
        );
      }
    } else if (widget.category == 'spelling') {
      if (_selectedLanguage == 'Shona') {
        return GridView.count(
          crossAxisCount: 2, crossAxisSpacing: 16, mainAxisSpacing: 16,
          children: [
            _buildSpellingCard('B', 'Banga', 'Banga. Ba, Ba, Banga.', Colors.redAccent),
            _buildSpellingCard('M', 'Mombe', 'Mombe. Ma, Ma, Mombe.', Colors.blueAccent),
            _buildSpellingCard('N', 'Nyoka', 'Nyoka. Nya, Nya, Nyoka.', Colors.orangeAccent),
            _buildSpellingCard('S', 'Shumba', 'Shumba. Sha, Sha, Shumba.', Colors.greenAccent),
          ],
        );
      } else if (_selectedLanguage == 'Ndebele') {
        return GridView.count(
          crossAxisCount: 2, crossAxisSpacing: 16, mainAxisSpacing: 16,
          children: [
            _buildSpellingCard('I', 'Inja', 'Inja. I, I, Inja.', Colors.redAccent),
            _buildSpellingCard('N', 'Ndwangu', 'Ndwangu. Na, Na, Ndwangu.', Colors.blueAccent),
            _buildSpellingCard('S', 'Silwane', 'Silwane. Sa, Sa, Silwane.', Colors.orangeAccent),
            _buildSpellingCard('U', 'Uvundla', 'Uvundla. U, U, Uvundla.', Colors.greenAccent),
          ],
        );
      } else {
        return GridView.count(
          crossAxisCount: 2, crossAxisSpacing: 16, mainAxisSpacing: 16,
          children: [
            _buildSpellingCard('A', 'Apple', 'A is for Apple. Ah, Ah, Apple.', Colors.redAccent),
            _buildSpellingCard('B', 'Baboon', 'B is for Baboon. B, B, Baboon.', Colors.blueAccent),
            _buildSpellingCard('C', 'Cat', 'C is for Cat. C, C, Cat.', Colors.orangeAccent),
            _buildSpellingCard('D', 'Dog', 'D is for Dog. D, D, Dog.', Colors.greenAccent),
          ],
        );
      }
    } else {
      return Center(
        child: Text('Coming Soon! Color and Read...', style: TextStyle(color: AppTheme.white70, fontSize: 18)),
      );
    }
  }

  Widget _buildPlayCard(String title, String story, Color accentColor) {
    bool isActive = _isPlaying && _currentText == story;
    return GlassCard(
      padding: const EdgeInsets.all(20),
      borderColor: accentColor.withValues(alpha: 0.4),
      boxShadow: [if (isActive) BoxShadow(color: accentColor.withValues(alpha: 0.3), blurRadius: 15)],
      onTap: () => _speak(story),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.music_note, color: accentColor),
              const SizedBox(width: 8),
              Expanded(child: Text(title, style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold))),
              Icon(isActive ? Icons.pause_circle_filled : Icons.play_circle_fill, color: accentColor, size: 40),
            ],
          ),
          const SizedBox(height: 12),
          Text(story, style: const TextStyle(color: Colors.white70, fontSize: 16, height: 1.5)),
        ],
      ),
    );
  }

  Widget _buildSpellingCard(String letter, String word, String speech, Color accentColor) {
    bool isActive = _isPlaying && _currentText == speech;
    return GlassCard(
      padding: const EdgeInsets.all(16),
      borderColor: accentColor.withValues(alpha: 0.4),
      boxShadow: [if (isActive) BoxShadow(color: accentColor.withValues(alpha: 0.3), blurRadius: 15)],
      onTap: () => _speak(speech),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(letter, style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: accentColor)),
          const SizedBox(height: 8),
          Text(word, style: const TextStyle(fontSize: 18, color: Colors.white)),
          const SizedBox(height: 12),
          Icon(isActive ? Icons.volume_up : Icons.volume_down, color: accentColor, size: 30),
        ],
      ),
    );
  }
}
