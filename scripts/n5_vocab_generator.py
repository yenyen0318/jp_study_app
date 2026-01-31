import json
import uuid

# Helper to create vocabulary entry
def create_vocab(text, furigana, romaji, meaning, tags, segments=None):
    if segments is None:
        # Default simple segmentation for single kanji words or words without kanji
        if text == furigana:
             segments = [{'text': text, 'reading': None}]
        else:
             segments = [{'text': text, 'reading': furigana}]

    return {
        "id": f"v_n5_{uuid.uuid4().hex[:8]}",
        "text": text,
        "furigana": furigana,
        "romaji": romaji,
        "segments": segments,
        "meaning": meaning,
        "tags": ["N5"] + tags,
        "masteryLevel": 0
    }

def main():
    vocab_list = []

    # --- 1. 挨拶 (Greetings) ---
    greetings = [
        ("おはよう", "おはよう", "ohayou", "早安 (簡)", ["問候語"]),
        ("おはようございます", "おはようございます", "ohayou gozaimasu", "早安 (敬)", ["問候語"]),
        ("こんにちは", "こんにちは", "konnichiwa", "你好", ["問候語"]),
        ("こんばんは", "こんばんは", "konbanwa", "晚上好", ["問候語"]),
        ("おやすみなさい", "おやすみなさい", "oyasuminasai", "晚安", ["問候語"]),
        ("さようなら", "さようなら", "sayounara", "再見", ["問候語"]),
        ("ありがとうございます", "ありがとうございます", "arigatou gozaimasu", "謝謝", ["問候語"]),
        ("すみません", "すみません", "sumimasen", "不好意思 / 對不起", ["問候語"]),
        ("ごめんなさい", "ごめんなさい", "gomennasai", "對不起", ["問候語"]),
        ("いただきます", "いただきます", "itadakimasu", "我開動了", ["問候語"]),
        ("ごちそうさまでした", "ごちそうさまでした", "gochisousamadeshita", "多謝款待", ["問候語"]),
        ("はじめまして", "はじめまして", "hajimemashite", "初次見面", ["問候語"]),
        ("よろしくおねがいします", "よろしくおねがいします", "yoroshiku onegaishimasu", "請多指教", ["問候語"]),
        ("いってきます", "いってきます", "ittekimasu", "我出門了", ["問候語"]),
        ("いってらっしゃい", "いってらっしゃい", "itterasshai", "慢走", ["問候語"]),
        ("ただいま", "ただいま", "tadaima", "我回來了", ["問候語"]),
        ("おかえりなさい", "おかえりなさい", "okaerinasai", "歡迎回來", ["問候語"]),
        ("おげんきですか", "おげんきですか", "ogenki desu ka", "你好嗎？", ["問候語"]),
        ("どういたしまして", "どういたしまして", "douitashimashite", "不客氣", ["問候語"]),
    ]
    for v in greetings:
        vocab_list.append(create_vocab(v[0], v[1], v[2], v[3], v[4]))

    # --- 2. 代名詞 / 指示詞 (Pronouns) ---
    pronouns = [
        ("私", "わたし", "watashi", "我", ["代名詞"], [{'text': '私', 'reading': 'わたし'}]),
        ("私たち", "わたしたち", "watashitachi", "我們", ["代名詞"], [{'text': '私', 'reading': 'わたし'}, {'text': 'たち', 'reading': None}]),
        ("あなた", "あなた", "anata", "你", ["代名詞"]),
        ("彼", "かれ", "kare", "他", ["代名詞"], [{'text': '彼', 'reading': 'かれ'}]),
        ("彼女", "かのじょ", "kanojo", "她", ["代名詞"], [{'text': '彼女', 'reading': 'かのじょ'}]),
        ("これ", "これ", "kore", "這個 (近)", ["代名詞", "指示詞"]),
        ("それ", "それ", "sore", "那個 (中)", ["代名詞", "指示詞"]),
        ("あれ", "あれ", "are", "那個 (遠)", ["代名詞", "指示詞"]),
        ("どれ", "どれ", "dore", "哪個", ["代名詞", "疑問詞"]),
        ("この", "この", "kono", "這個...", ["連體詞", "指示詞"]),
        ("その", "その", "sono", "那個...", ["連體詞", "指示詞"]),
        ("あの", "あの", "ano", "那個...", ["連體詞", "指示詞"]),
        ("どの", "どの", "dono", "哪個...", ["連體詞", "疑問詞"]),
        ("ここ", "ここ", "koko", "這裡", ["代名詞", "指示詞"]),
        ("そこ", "そこ", "soko", "那裡", ["代名詞", "指示詞"]),
        ("あそこ", "あそこ", "asoko", "那裡 (遠)", ["代名詞", "指示詞"]),
        ("どこ", "どこ", "doko", "哪裡", ["代名詞", "疑問詞"]),
        ("だれ", "だれ", "dare", "誰", ["代名詞", "疑問詞"]),
        ("どなた", "どなた", "donata", "哪位 (敬)", ["代名詞", "疑問詞"]),
    ]
    for v in pronouns:
        segs = v[5] if len(v) > 5 else None
        vocab_list.append(create_vocab(v[0], v[1], v[2], v[3], v[4], segs))

    # --- 3. 時間 (Time) ---
    time_words = [
        ("今", "いま", "ima", "現在", ["名詞", "時間"], [{'text': '今', 'reading': 'いま'}]),
        ("今日", "きょう", "kyou", "今天", ["名詞", "時間"], [{'text': '今日', 'reading': 'きょう'}]),
        ("明日", "あした", "ashita", "明天", ["名詞", "時間"], [{'text': '明日', 'reading': 'あした'}]),
        ("昨日", "きのう", "kinou", "昨天", ["名詞", "時間"], [{'text': '昨日', 'reading': 'きのう'}]),
        ("毎日", "まいにち", "mainichi", "每天", ["名詞", "時間"], [{'text': '毎', 'reading': 'まい'}, {'text': '日', 'reading': 'にち'}]),
        ("朝", "あさ", "asa", "早上", ["名詞", "時間"], [{'text': '朝', 'reading': 'あさ'}]),
        ("昼", "ひる", "hiru", "中午/白天", ["名詞", "時間"], [{'text': '昼', 'reading': 'ひる'}]),
        ("晩", "ばん", "ban", "晚上", ["名詞", "時間"], [{'text': '晩', 'reading': 'ばん'}]),
        ("夜", "よる", "yoru", "夜晚", ["名詞", "時間"], [{'text': '夜', 'reading': 'よる'}]),
        ("午前", "ごぜん", "gozen", "上午", ["名詞", "時間"], [{'text': '午', 'reading': 'ご'}, {'text': '前', 'reading': 'ぜん'}]),
        ("午後", "ごご", "gogo", "下午", ["名詞", "時間"], [{'text': '午', 'reading': 'ご'}, {'text': '後', 'reading': 'ご'}]),
        ("月曜日", "げつようび", "getsuyoubi", "星期一", ["名詞", "時間"], [{'text': '月', 'reading': 'げつ'}, {'text': '曜', 'reading': 'よう'}, {'text': '日', 'reading': 'び'}]),
        ("火曜日", "かようび", "kayoubi", "星期二", ["名詞", "時間"], [{'text': '火', 'reading': 'か'}, {'text': '曜', 'reading': 'よう'}, {'text': '日', 'reading': 'び'}]),
        ("水曜日", "すいようび", "suiyoubi", "星期三", ["名詞", "時間"], [{'text': '水', 'reading': 'すい'}, {'text': '曜', 'reading': 'よう'}, {'text': '日', 'reading': 'び'}]),
        ("木曜日", "もくようび", "mokuyoubi", "星期四", ["名詞", "時間"], [{'text': '木', 'reading': 'もく'}, {'text': '曜', 'reading': 'よう'}, {'text': '日', 'reading': 'び'}]),
        ("金曜日", "きんようび", "kinyoubi", "星期五", ["名詞", "時間"], [{'text': '金', 'reading': 'きん'}, {'text': '曜', 'reading': 'よう'}, {'text': '日', 'reading': 'び'}]),
        ("土曜日", "どようび", "doyoubi", "星期六", ["名詞", "時間"], [{'text': '土', 'reading': 'ど'}, {'text': '曜', 'reading': 'よう'}, {'text': '日', 'reading': 'び'}]),
        ("日曜日", "にちようび", "nichiyoubi", "星期日", ["名詞", "時間"], [{'text': '日', 'reading': 'にち'}, {'text': '曜', 'reading': 'よう'}, {'text': '日', 'reading': 'び'}]),
        ("何時", "なんじ", "nanji", "幾點", ["名詞", "疑問詞"], [{'text': '何', 'reading': 'なん'}, {'text': '時', 'reading': 'じ'}]),
        ("分", "ふん", "fun", "分 (單位)", ["名詞", "時間"], [{'text': '分', 'reading': 'ふん'}]),
        ("年", "とし", "toshi", "年", ["名詞", "時間"], [{'text': '年', 'reading': 'とし'}]),
        ("月", "つき", "tsuki", "月", ["名詞", "時間"], [{'text': '月', 'reading': 'つき'}]),
        ("週", "しゅう", "shuu", "週", ["名詞", "時間"], [{'text': '週', 'reading': 'しゅう'}]),
        ("先週", "せんしゅう", "senshuu", "上週", ["名詞", "時間"], [{'text': '先', 'reading': 'せん'}, {'text': '週', 'reading': 'しゅう'}]),
        ("今週", "こんしゅう", "konshuu", "本週", ["名詞", "時間"], [{'text': '今', 'reading': 'こん'}, {'text': '週', 'reading': 'しゅう'}]),
        ("来週", "らいしゅう", "raishuu", "下週", ["名詞", "時間"], [{'text': '来', 'reading': 'らい'}, {'text': '週', 'reading': 'しゅう'}]),
        ("先月", "せんげつ", "sengetsu", "上個月", ["名詞", "時間"], [{'text': '先', 'reading': 'せん'}, {'text': '月', 'reading': 'げつ'}]),
        ("今月", "こんげつ", "kongetsu", "這個月", ["名詞", "時間"], [{'text': '今', 'reading': 'こん'}, {'text': '月', 'reading': 'げつ'}]),
        ("来月", "らいげつ", "raigetsu", "下個月", ["名詞", "時間"], [{'text': '来', 'reading': 'らい'}, {'text': '月', 'reading': 'げつ'}]),
        ("去年", "きょねん", "kyonen", "去年", ["名詞", "時間"], [{'text': '去', 'reading': 'きょ'}, {'text': '年', 'reading': 'ねん'}]),
        ("今年", "ことし", "kotoshi", "今年", ["名詞", "時間"], [{'text': '今年', 'reading': 'ことし'}]),
        ("来年", "らいねん", "rainen", "明年", ["名詞", "時間"], [{'text': '来', 'reading': 'らい'}, {'text': '年', 'reading': 'ねん'}]),
    ]
    for v in time_words:
        segs = v[5] if len(v) > 5 else None
        vocab_list.append(create_vocab(v[0], v[1], v[2], v[3], v[4], segs))

    # --- 4. 名詞 - 人 (People) ---
    people = [
        ("人", "ひと", "hito", "人", ["名詞", "人稱"], [{'text': '人', 'reading': 'ひと'}]),
        ("男", "おとこ", "otoko", "男人", ["名詞", "人稱"], [{'text': '男', 'reading': 'おとこ'}]),
        ("女", "おんな", "onna", "女人", ["名詞", "人稱"], [{'text': '女', 'reading': 'おんな'}]),
        ("子", "こ", "ko", "孩子", ["名詞", "人稱"], [{'text': '子', 'reading': 'こ'}]),
        ("父", "ちち", "chichi", "父親 (自稱)", ["名詞", "人稱", "家庭"], [{'text': '父', 'reading': 'ちち'}]),
        ("母", "はは", "haha", "母親 (自稱)", ["名詞", "人稱", "家庭"], [{'text': '母', 'reading': 'はは'}]),
        ("お父さん", "おとうさん", "otousan", "父親 (敬稱)", ["名詞", "人稱", "家庭"], [{'text': 'お', 'reading': None}, {'text': '父', 'reading': 'とう'}, {'text': 'さん', 'reading': None}]),
        ("お母さん", "おかあさん", "okaasan", "母親 (敬稱)", ["名詞", "人稱", "家庭"], [{'text': 'お', 'reading': None}, {'text': '母', 'reading': 'かあ'}, {'text': 'さん', 'reading': None}]),
        ("先生", "せんせい", "sensei", "老師", ["名詞", "人稱"], [{'text': '先', 'reading': 'せん'}, {'text': '生', 'reading': 'せい'}]),
        ("学生", "がくせい", "gakusei", "學生", ["名詞", "人稱"], [{'text': '学', 'reading': 'がく'}, {'text': '生', 'reading': 'せい'}]),
        ("友達", "ともだち", "tomodachi", "朋友", ["名詞", "人稱"], [{'text': '友', 'reading': 'とも'}, {'text': '達', 'reading': 'だち'}]),
        ("大人", "おとな", "otona", "大人", ["名詞", "人稱"], [{'text': '大人', 'reading': 'おとな'}]),
        ("外国人", "がいこくじん", "gaikokujin", "外國人", ["名詞", "人稱"], [{'text': '外', 'reading': 'がい'}, {'text': '国', 'reading': 'こく'}, {'text': '人', 'reading': 'じん'}]),
    ]
    for v in people:
        segs = v[5] if len(v) > 5 else None
        vocab_list.append(create_vocab(v[0], v[1], v[2], v[3], v[4], segs))

    # --- 5. 名詞 - 地點 (Places) ---
    places = [
        ("家", "いえ", "ie", "家/房子", ["名詞", "場所"], [{'text': '家', 'reading': 'いえ'}]),
        ("部屋", "へや", "heya", "房間", ["名詞", "場所"], [{'text': '部', 'reading': 'へ'}, {'text': '屋', 'reading': 'や'}]),
        ("学校", "がっこう", "gakkou", "學校", ["名詞", "場所"], [{'text': '学', 'reading': 'がっ'}, {'text': '校', 'reading': 'こう'}]),
        ("教室", "きょうしつ", "kyoushitsu", "教室", ["名詞", "場所"], [{'text': '教', 'reading': 'きょう'}, {'text': '室', 'reading': 'しつ'}]),
        ("食堂", "しょくどう", "shokudou", "食堂", ["名詞", "場所"], [{'text': '食', 'reading': 'しょく'}, {'text': '堂', 'reading': 'どう'}]),
        ("会社", "かいしゃ", "kaisha", "公司", ["名詞", "場所"], [{'text': '会', 'reading': 'かい'}, {'text': '社', 'reading': 'しゃ'}]),
        ("病院", "びょういん", "byouin", "醫院", ["名詞", "場所"], [{'text': '病', 'reading': 'びょう'}, {'text': '院', 'reading': 'いん'}]),
        ("銀行", "ぎんこう", "ginkou", "銀行", ["名詞", "場所"], [{'text': '銀', 'reading': 'ぎん'}, {'text': '行', 'reading': 'こう'}]),
        ("郵便局", "ゆうびんきょく", "yuubinkyoku", "郵局", ["名詞", "場所"], [{'text': '郵', 'reading': 'ゆう'}, {'text': '便', 'reading': 'びん'}, {'text': '局', 'reading': 'きょく'}]),
        ("図書館", "としょかん", "toshokan", "圖書館", ["名詞", "場所"], [{'text': '図', 'reading': 'と'}, {'text': '書', 'reading': 'しょ'}, {'text': '館', 'reading': 'かん'}]),
        ("駅", "えき", "eki", "車站", ["名詞", "場所", "交通"], [{'text': '駅', 'reading': 'えき'}]),
        ("店", "みせ", "mise", "店", ["名詞", "場所"], [{'text': '店', 'reading': 'みせ'}]),
        ("デパート", "デパート", "depaato", "百貨公司", ["名詞", "場所"]),
        ("スーパー", "スーパー", "suupaa", "超市", ["名詞", "場所"]),
        ("コンビニ", "コンビニ", "konbini", "便利商店", ["名詞", "場所"]),
        ("公園", "こうえん", "kouen", "公園", ["名詞", "場所"], [{'text': '公', 'reading': 'こう'}, {'text': '園', 'reading': 'えん'}]),
        ("交番", "こうばん", "kouban", "派出所", ["名詞", "場所"], [{'text': '交', 'reading': 'こう'}, {'text': '番', 'reading': 'ばん'}]),
        ("海", "うみ", "umi", "海", ["名詞", "場所", "自然"], [{'text': '海', 'reading': 'うみ'}]),
        ("山", "やま", "yama", "山", ["名詞", "場所", "自然"], [{'text': '山', 'reading': 'やま'}]),
        ("川", "かわ", "kawa", "河川", ["名詞", "場所", "自然"], [{'text': '川', 'reading': 'かわ'}]),
        ("国", "くに", "kuni", "國家", ["名詞", "場所"], [{'text': '国', 'reading': 'くに'}]),
    ]
    for v in places:
        segs = v[5] if len(v) > 5 else None
        vocab_list.append(create_vocab(v[0], v[1], v[2], v[3], v[4], segs))

    # --- 6. 形容詞 (Adjectives) ---
    adjectives = [
        ("大きい", "おおきい", "ookii", "大的", ["い形容詞"], [{'text': '大', 'reading': 'おお'}, {'text': 'きい', 'reading': None}]),
        ("小さい", "ちいさい", "chiisai", "小的", ["い形容詞"], [{'text': '小', 'reading': 'ちい'}, {'text': 'さい', 'reading': None}]),
        ("新しい", "あたらしい", "atarashii", "新的", ["い形容詞"], [{'text': '新', 'reading': 'あたら'}, {'text': 'しい', 'reading': None}]),
        ("古い", "ふるい", "furui", "舊的", ["い形容詞"], [{'text': '古', 'reading': 'ふる'}, {'text': 'い', 'reading': None}]),
        ("いい", "いい", "ii", "好的", ["い形容詞"]),
        ("悪い", "わるい", "warui", "壞的", ["い形容詞"], [{'text': '悪', 'reading': 'わる'}, {'text': 'い', 'reading': None}]),
        ("暑い", "あつい", "atsui", "熱的 (天氣)", ["い形容詞"], [{'text': '暑', 'reading': 'あつ'}, {'text': 'い', 'reading': None}]),
        ("寒い", "さむい", "samui", "冷的 (天氣)", ["い形容詞"], [{'text': '寒', 'reading': 'さむ'}, {'text': 'い', 'reading': None}]),
        ("熱い", "あつい", "atsui", "燙的 (物)", ["い形容詞"], [{'text': '熱', 'reading': 'あつ'}, {'text': 'い', 'reading': None}]),
        ("冷たい", "つめたい", "tsumetai", "冰的 (物)", ["い形容詞"], [{'text': '冷', 'reading': 'つめ'}, {'text': 'たい', 'reading': None}]),
        ("高い", "たかい", "takai", "高的/貴的", ["い形容詞"], [{'text': '高', 'reading': 'たか'}, {'text': 'い', 'reading': None}]),
        ("安い", "やすい", "yasui", "便宜的", ["い形容詞"], [{'text': '安', 'reading': 'やす'}, {'text': 'い', 'reading': None}]),
        ("低い", "ひくい", "hikui", "低的", ["い形容詞"], [{'text': '低', 'reading': 'ひく'}, {'text': 'い', 'reading': None}]),
        ("おもしろい", "おもしろい", "omoshiroi", "有趣的", ["い形容詞"]),
        ("おいしい", "おいしい", "oishii", "好吃的", ["い形容詞"]),
        ("忙しい", "いそがしい", "isogashii", "忙碌的", ["い形容詞"], [{'text': '忙', 'reading': 'いそが'}, {'text': 'しい', 'reading': None}]),
        ("楽しい", "たのしい", "tanoshii", "快樂的", ["い形容詞"], [{'text': '楽', 'reading': 'たの'}, {'text': 'しい', 'reading': None}]),
        ("白い", "しろい", "shiroi", "白色的", ["い形容詞"], [{'text': '白', 'reading': 'しろ'}, {'text': 'い', 'reading': None}]),
        ("黒い", "くろい", "kuroi", "黑色的", ["い形容詞"], [{'text': '黒', 'reading': 'くろ'}, {'text': 'い', 'reading': None}]),
        ("赤い", "あかい", "akai", "紅色的", ["い形容詞"], [{'text': '赤', 'reading': 'あか'}, {'text': 'い', 'reading': None}]),
        ("青い", "あおい", "aoi", "藍色的", ["い形容詞"], [{'text': '青', 'reading': 'あお'}, {'text': 'い', 'reading': None}]),
        ("きれい", "きれい", "kirei", "漂亮的/乾淨的", ["な形容詞"]),
        ("静か", "しずか", "shizuka", "安靜的", ["な形容詞"], [{'text': '静', 'reading': 'しず'}, {'text': 'か', 'reading': None}]),
        ("賑やか", "にぎやか", "nigiyaka", "熱鬧的", ["な形容詞"], [{'text': '賑', 'reading': 'にぎ'}, {'text': 'やか', 'reading': None}]),
        ("有名", "ゆうめい", "yuumei", "有名的", ["な形容詞"], [{'text': '有', 'reading': 'ゆう'}, {'text': '名', 'reading': 'めい'}]),
        ("親切", "しんせつ", "shinsetsu", "親切的", ["な形容詞"], [{'text': '親', 'reading': 'しん'}, {'text': '切', 'reading': 'せつ'}]),
        ("元気", "げんき", "genki", "有精神的/健康的", ["な形容詞"], [{'text': '元', 'reading': 'げん'}, {'text': '気', 'reading': 'き'}]),
        ("暇", "ひま", "hima", "有空的", ["な形容詞"], [{'text': '暇', 'reading': 'ひま'}]),
        ("便利", "べんり", "benri", "方便的", ["な形容詞"], [{'text': '便', 'reading': 'べん'}, {'text': '利', 'reading': 'り'}]),
        ("すてき", "すてき", "suteki", "極好的", ["な形容詞"]),
        ("大好き", "だいすき", "daisuki", "最喜歡的", ["な形容詞"], [{'text': '大', 'reading': 'だい'}, {'text': '好', 'reading': 'す'}, {'text': 'き', 'reading': None}]),
        ("好き", "すき", "suki", "喜歡的", ["な形容詞"], [{'text': '好', 'reading': 'す'}, {'text': 'き', 'reading': None}]),
        ("嫌い", "きらい", "kirai", "討厭的", ["な形容詞"], [{'text': '嫌', 'reading': 'きら'}, {'text': 'い', 'reading': None}]),
        ("上手", "じょうず", "jouzu", "擅長的", ["な形容詞"], [{'text': '上', 'reading': 'じょう'}, {'text': '手', 'reading': 'ず'}]),
        ("下手", "へた", "heta", "不擅長的", ["な形容詞"], [{'text': '下', 'reading': 'へ'}, {'text': '手', 'reading': 'た'}]),
        ("いろいろ", "いろいろ", "iroiro", "各式各樣的", ["な形容詞"]),
    ]
    for v in adjectives:
        segs = v[5] if len(v) > 5 else None
        vocab_list.append(create_vocab(v[0], v[1], v[2], v[3], v[4], segs))

    # --- 7. 動詞 (Verbs) ---
    verbs = [
        ("行く", "いく", "iku", "去", ["動詞", "一類動詞"], [{'text': '行', 'reading': 'い'}, {'text': 'く', 'reading': None}]),
        ("来る", "くる", "kuru", "來", ["動詞", "三類動詞"], [{'text': '来', 'reading': 'く'}, {'text': 'る', 'reading': None}]),
        ("帰る", "かえる", "kaeru", "回去", ["動詞", "一類動詞"], [{'text': '帰', 'reading': 'かえ'}, {'text': 'る', 'reading': None}]),
        ("食べる", "たべる", "taberu", "吃", ["動詞", "二類動詞"], [{'text': '食', 'reading': 'た'}, {'text': 'べる', 'reading': None}]),
        ("飲む", "のむ", "nomu", "喝", ["動詞", "一類動詞"], [{'text': '飲', 'reading': 'の'}, {'text': 'む', 'reading': None}]),
        ("見る", "みる", "miru", "看", ["動詞", "二類動詞"], [{'text': '見', 'reading': 'み'}, {'text': 'る', 'reading': None}]),
        ("聞く", "きく", "kiku", "聽", ["動詞", "一類動詞"], [{'text': '聞', 'reading': 'き'}, {'text': 'く', 'reading': None}]),
        ("読む", "よむ", "yomu", "讀", ["動詞", "一類動詞"], [{'text': '読', 'reading': 'よ'}, {'text': 'む', 'reading': None}]),
        ("書く", "かく", "kaku", "寫", ["動詞", "一類動詞"], [{'text': '書', 'reading': 'か'}, {'text': 'く', 'reading': None}]),
        ("話す", "はなす", "hanasu", "說", ["動詞", "一類動詞"], [{'text': '話', 'reading': 'はな'}, {'text': 'す', 'reading': None}]),
        ("買う", "かう", "kau", "買", ["動詞", "一類動詞"], [{'text': '買', 'reading': 'か'}, {'text': 'う', 'reading': None}]),
        ("待つ", "まつ", "matsu", "等待", ["動詞", "一類動詞"], [{'text': '待', 'reading': 'ま'}, {'text': 'つ', 'reading': None}]),
        ("会う", "あう", "au", "見面", ["動詞", "一類動詞"], [{'text': '会', 'reading': 'あ'}, {'text': 'う', 'reading': None}]),
        ("呼ぶ", "よぶ", "yobu", "呼叫", ["動詞", "一類動詞"], [{'text': '呼', 'reading': 'よ'}, {'text': 'ぶ', 'reading': None}]),
        ("教える", "おしえる", "oshieru", "教導", ["動詞", "二類動詞"], [{'text': '教', 'reading': 'おし'}, {'text': 'える', 'reading': None}]),
        ("起きる", "おきる", "okiru", "起床", ["動詞", "二類動詞"], [{'text': '起', 'reading': 'お'}, {'text': 'きる', 'reading': None}]),
        ("寝る", "ねる", "neru", "睡覺", ["動詞", "二類動詞"], [{'text': '寝', 'reading': 'ね'}, {'text': 'る', 'reading': None}]),
        ("働く", "はたらく", "hataraku", "工作", ["動詞", "一類動詞"], [{'text': '働', 'reading': 'はたら'}, {'text': 'く', 'reading': None}]),
        ("勉強する", "べんきょうする", "benkyousuru", "學習", ["動詞", "三類動詞", "する動詞"], [{'text': '勉強', 'reading': 'べんきょう'}, {'text': 'する', 'reading': None}]),
        ("する", "する", "suru", "做", ["動詞", "三類動詞"], [{'text': 'する', 'reading': None}]),
        ("ある", "ある", "aru", "有 (無生物)", ["動詞", "一類動詞"], [{'text': 'ある', 'reading': None}]),
        ("いる", "いる", "iru", "有 (生物)", ["動詞", "二類動詞"], [{'text': 'いる', 'reading': None}]),
    ]
    for v in verbs:
        segs = v[5] if len(v) > 5 else None
        vocab_list.append(create_vocab(v[0], v[1], v[2], v[3], v[4], segs))

    # --- 8. 飲食 (Food & Drink) ---
    food = [
        ("ご飯", "ごはん", "gohan", "飯/餐", ["名詞", "食物"], [{'text': 'ご', 'reading': None}, {'text': '飯', 'reading': 'はん'}]),
        ("朝ご飯", "あさごはん", "asagohan", "早餐", ["名詞", "食物"], [{'text': '朝', 'reading': 'あさ'}, {'text': 'ご', 'reading': None}, {'text': '飯', 'reading': 'はん'}]),
        ("昼ご飯", "ひるごはん", "hirugohan", "午餐", ["名詞", "食物"], [{'text': '昼', 'reading': 'ひる'}, {'text': 'ご', 'reading': None}, {'text': '飯', 'reading': 'はん'}]),
        ("晩ご飯", "ばんごはん", "bangohan", "晚餐", ["名詞", "食物"], [{'text': '晩', 'reading': 'ばん'}, {'text': 'ご', 'reading': None}, {'text': '飯', 'reading': 'はん'}]),
        ("パン", "パン", "pan", "麵包", ["名詞", "食物"]),
        ("卵", "たまご", "tamago", "雞蛋", ["名詞", "食物"], [{'text': '卵', 'reading': 'たまご'}]),
        ("肉", "にく", "niku", "肉", ["名詞", "食物"], [{'text': '肉', 'reading': 'にく'}]),
        ("魚", "さかな", "sakana", "魚", ["名詞", "食物"], [{'text': '魚', 'reading': 'さかな'}]),
        ("野菜", "やさい", "yasai", "蔬菜", ["名詞", "食物"], [{'text': '野', 'reading': 'や'}, {'text': '菜', 'reading': 'さい'}]),
        ("果物", "くだもの", "kudamono", "水果", ["名詞", "食物"], [{'text': '果', 'reading': 'くだ'}, {'text': '物', 'reading': 'もの'}]),
        ("水", "みず", "mizu", "水", ["名詞", "食物"], [{'text': '水', 'reading': 'みず'}]),
        ("お茶", "おちゃ", "ocha", "茶", ["名詞", "食物"], [{'text': 'お', 'reading': None}, {'text': '茶', 'reading': 'ちゃ'}]),
        ("紅茶", "こうちゃ", "koucha", "紅茶", ["名詞", "食物"], [{'text': '紅', 'reading': 'こう'}, {'text': '茶', 'reading': 'ちゃ'}]),
        ("牛乳", "ぎゅうにゅう", "gyuunyuu", "牛奶", ["名詞", "食物"], [{'text': '牛', 'reading': 'ぎゅう'}, {'text': '乳', 'reading': 'にゅう'}]),
        ("ジュース", "ジュース", "juusu", "果汁", ["名詞", "食物"]),
        ("ビール", "ビール", "biiru", "啤酒", ["名詞", "食物"]),
        ("お酒", "おさけ", "osake", "酒", ["名詞", "食物"], [{'text': 'お', 'reading': None}, {'text': '酒', 'reading': 'さけ'}]),
        ("料理", "りょうり", "ryouri", "料理", ["名詞", "食物"], [{'text': '料', 'reading': 'りょう'}, {'text': '理', 'reading': 'り'}]),
        ("レストラン", "レストラン", "resutoran", "餐廳", ["名詞", "場所"]),
        ("喫茶店", "きっさてん", "kissaten", "咖啡廳", ["名詞", "場所"], [{'text': '喫', 'reading': 'きっ'}, {'text': '茶', 'reading': 'さ'}, {'text': '店', 'reading': 'てん'}]),
        ("塩", "しお", "shio", "鹽", ["名詞", "食物"], [{'text': '塩', 'reading': 'しお'}]),
        ("砂糖", "さとう", "satou", "糖", ["名詞", "食物"], [{'text': '砂', 'reading': 'さ'}, {'text': '糖', 'reading': 'とう'}]),
        ("醤油", "しょうゆ", "shouyu", "醬油", ["名詞", "食物"], [{'text': '醤', 'reading': 'しょう'}, {'text': '油', 'reading': 'ゆ'}]),
        ("味噌", "みそ", "miso", "味噌", ["名詞", "食物"], [{'text': '味', 'reading': 'み'}, {'text': '噌', 'reading': 'そ'}]),
        ("箸", "はし", "hashi", "筷子", ["名詞", "日用品"], [{'text': '箸', 'reading': 'はし'}]),
        ("スプーン", "スプーン", "supuun", "湯匙", ["名詞", "日用品"]),
        ("フォーク", "フォーク", "fooku", "叉子", ["名詞", "日用品"]),
        ("ナイフ", "ナイフ", "naifu", "刀子", ["名詞", "日用品"]),
        ("お弁当", "おべんとう", "obentou", "便當", ["名詞", "食物"], [{'text': 'お', 'reading': None}, {'text': '弁', 'reading': 'べん'}, {'text': '当', 'reading': 'とう'}]),
        ("カレーライス", "カレーライス", "kareeraisu", "咖哩飯", ["名詞", "食物"]),
    ]
    for v in food:
        segs = v[5] if len(v) > 5 else None
        vocab_list.append(create_vocab(v[0], v[1], v[2], v[3], v[4], segs))

    # --- 9. 日用品 (Daily Necessities) ---
    daily_items = [
        ("手紙", "てがみ", "tegami", "信", ["名詞", "日用品"], [{'text': '手', 'reading': 'て'}, {'text': '紙', 'reading': 'がみ'}]),
        ("電話", "でんわ", "denwa", "電話", ["名詞", "日用品"], [{'text': '電', 'reading': 'でん'}, {'text': '話', 'reading': 'わ'}]),
        ("携帯電話", "けいたいでんわ", "keitaidenwa", "手機", ["名詞", "日用品"], [{'text': '携', 'reading': 'けい'}, {'text': '帯', 'reading': 'たい'}, {'text': '電', 'reading': 'でん'}, {'text': '話', 'reading': 'わ'}]),
        ("スマホ", "スマホ", "sumaho", "智慧型手機", ["名詞", "日用品"]),
        ("傘", "かさ", "kasa", "傘", ["名詞", "日用品"], [{'text': '傘', 'reading': 'かさ'}]),
        ("時計", "とけい", "tokei", "時鐘/手錶", ["名詞", "日用品"], [{'text': '時', 'reading': 'と'}, {'text': '計', 'reading': 'けい'}]),
        ("眼鏡", "めがね", "megane", "眼鏡", ["名詞", "日用品"], [{'text': '眼', 'reading': 'め'}, {'text': '鏡', 'reading': 'がね'}]),
        ("財布", "さいふ", "saifu", "錢包", ["名詞", "日用品"], [{'text': '財', 'reading': 'さい'}, {'text': '布', 'reading': 'ふ'}]),
        ("鍵", "かぎ", "kagi", "鑰匙", ["名詞", "日用品"], [{'text': '鍵', 'reading': 'かぎ'}]),
        ("靴", "くつ", "kutsu", "鞋子", ["名詞", "日用品", "衣物"], [{'text': '靴', 'reading': 'くつ'}]),
        ("鞄", "かばん", "kaban", "包包", ["名詞", "日用品"], [{'text': '鞄', 'reading': 'かばん'}]),
        ("本", "ほん", "hon", "書", ["名詞", "日用品"], [{'text': '本', 'reading': 'ほん'}]),
        ("辞書", "じしょ", "jisho", "辭典", ["名詞", "日用品"], [{'text': '辞', 'reading': 'じ'}, {'text': '書', 'reading': 'しょ'}]),
        ("雑誌", "ざっし", "zasshi", "雜誌", ["名詞", "日用品"], [{'text': '雑', 'reading': 'ざっ'}, {'text': '誌', 'reading': 'し'}]),
        ("新聞", "しんぶん", "shinbun", "報紙", ["名詞", "日用品"], [{'text': '新', 'reading': 'しん'}, {'text': '聞', 'reading': 'ぶん'}]),
        ("鉛筆", "えんぴつ", "enpitsu", "鉛筆", ["名詞", "日用品", "文具"], [{'text': '鉛', 'reading': 'えん'}, {'text': '筆', 'reading': 'ぴつ'}]),
        ("ボールペン", "ボールペン", "boorupen", "原子筆", ["名詞", "日用品", "文具"]),
        ("ノート", "ノート", "nooto", "筆記本", ["名詞", "日用品", "文具"]),
        ("カレンダー", "カレンダー", "karendaa", "月曆", ["名詞", "日用品"]),
        ("写真", "しゃしん", "shashin", "照片", ["名詞", "日用品"], [{'text': '写', 'reading': 'しゃ'}, {'text': '真', 'reading': 'しん'}]),
        ("石鹸", "せっけん", "sekken", "肥皂", ["名詞", "日用品"], [{'text': '石', 'reading': 'せっ'}, {'text': '鹸', 'reading': 'けん'}]),
        ("切手", "きって", "kitte", "郵票", ["名詞", "日用品"], [{'text': '切', 'reading': 'きっ'}, {'text': '手', 'reading': 'て'}]),
        ("封筒", "ふうとう", "fuutou", "信封", ["名詞", "日用品"], [{'text': '封', 'reading': 'ふう'}, {'text': '筒', 'reading': 'とう'}]),
        ("はがき", "はがき", "hagaki", "明信片", ["名詞", "日用品"]),
    ]
    for v in daily_items:
        segs = v[5] if len(v) > 5 else None
        vocab_list.append(create_vocab(v[0], v[1], v[2], v[3], v[4], segs))

    # --- 10. 交通 (Transport) ---
    transport = [
        ("車", "くるま", "kuruma", "車子", ["名詞", "交通"], [{'text': '車', 'reading': 'くるま'}]),
        ("自転車", "じてんしゃ", "jitensha", "腳踏車", ["名詞", "交通"], [{'text': '自', 'reading': 'じ'}, {'text': '転', 'reading': 'てん'}, {'text': '車', 'reading': 'しゃ'}]),
        ("電車", "でんしゃ", "densha", "電車", ["名詞", "交通"], [{'text': '電', 'reading': 'でん'}, {'text': '車', 'reading': 'しゃ'}]),
        ("地下鉄", "ちかてつ", "chikatetsu", "地下鐵", ["名詞", "交通"], [{'text': '地', 'reading': 'ち'}, {'text': '下', 'reading': 'か'}, {'text': '鉄', 'reading': 'てつ'}]),
        ("新幹線", "しんかんせん", "shinkansen", "新幹線", ["名詞", "交通"], [{'text': '新', 'reading': 'しん'}, {'text': '幹', 'reading': 'かん'}, {'text': '線', 'reading': 'せん'}]),
        ("バス", "バス", "basu", "公車", ["名詞", "交通"]),
        ("タクシー", "タクシー", "takushii", "計程車", ["名詞", "交通"]),
        ("飛行機", "ひこうき", "hikouki", "飛機", ["名詞", "交通"], [{'text': '飛', 'reading': 'ひ'}, {'text': '行', 'reading': 'こう'}, {'text': '機', 'reading': 'き'}]),
        ("船", "ふね", "fune", "船", ["名詞", "交通"], [{'text': '船', 'reading': 'ふね'}]),
        ("切符", "きっぷ", "kippu", "票 (車票)", ["名詞", "交通"], [{'text': '切', 'reading': 'きっ'}, {'text': '符', 'reading': 'ぷ'}]),
        ("道", "みち", "michi", "道路", ["名詞", "交通", "場所"], [{'text': '道', 'reading': 'みち'}]),
        ("信号", "しんごう", "shingou", "紅綠燈", ["名詞", "交通"], [{'text': '信', 'reading': 'しん'}, {'text': '号', 'reading': 'ごう'}]),
        ("角", "かど", "kado", "轉角", ["名詞", "交通"], [{'text': '角', 'reading': 'かど'}]),
        ("橋", "はし", "hashi", "橋", ["名詞", "交通", "場所"], [{'text': '橋', 'reading': 'はし'}]),
    ]
    for v in transport:
        segs = v[5] if len(v) > 5 else None
        vocab_list.append(create_vocab(v[0], v[1], v[2], v[3], v[4], segs))

    # --- 11. 方位與位置 (Directions) ---
    directions = [
        ("上", "うえ", "ue", "上面", ["名詞", "位置"], [{'text': '上', 'reading': 'うえ'}]),
        ("下", "した", "shita", "下面", ["名詞", "位置"], [{'text': '下', 'reading': 'した'}]),
        ("前", "まえ", "mae", "前面", ["名詞", "位置"], [{'text': '前', 'reading': 'まえ'}]),
        ("後ろ", "うしろ", "ushiro", "後面", ["名詞", "位置"], [{'text': '後', 'reading': 'うし'}, {'text': 'ろ', 'reading': None}]),
        ("右", "みぎ", "migi", "右邊", ["名詞", "位置"], [{'text': '右', 'reading': 'みぎ'}]),
        ("左", "ひだり", "hidari", "左邊", ["名詞", "位置"], [{'text': '左', 'reading': 'ひだり'}]),
        ("中", "なか", "naka", "裡面/中間", ["名詞", "位置"], [{'text': '中', 'reading': 'なか'}]),
        ("外", "そと", "soto", "外面", ["名詞", "位置"], [{'text': '外', 'reading': 'そと'}]),
        ("隣", "となり", "tonari", "旁邊 (同類)", ["名詞", "位置"], [{'text': '隣', 'reading': 'となり'}]),
        ("近く", "ちかく", "chikaku", "附近", ["名詞", "位置"], [{'text': '近', 'reading': 'ちか'}, {'text': 'く', 'reading': None}]),
        ("間", "あいだ", "aida", "之間", ["名詞", "位置"], [{'text': '間', 'reading': 'あいだ'}]),
        ("北", "きた", "kita", "北", ["名詞", "位置"], [{'text': '北', 'reading': 'きた'}]),
        ("南", "みなみ", "minami", "南", ["名詞", "位置"], [{'text': '南', 'reading': 'みなみ'}]),
        ("東", "ひがし", "higashi", "東", ["名詞", "位置"], [{'text': '東', 'reading': 'ひがし'}]),
        ("西", "にし", "nishi", "西", ["名詞", "位置"], [{'text': '西', 'reading': 'にし'}]),
    ]
    for v in directions:
        segs = v[5] if len(v) > 5 else None
        vocab_list.append(create_vocab(v[0], v[1], v[2], v[3], v[4], segs))

    # --- 12. 身體 (Body) ---
    body = [
        ("体", "からだ", "karada", "身體", ["名詞", "身體"], [{'text': '体', 'reading': 'からだ'}]),
        ("頭", "あたま", "atama", "頭", ["名詞", "身體"], [{'text': '頭', 'reading': 'あたま'}]),
        ("髪", "かみ", "kami", "頭髮", ["名詞", "身體"], [{'text': '髪', 'reading': 'かみ'}]),
        ("顔", "かお", "kao", "臉", ["名詞", "身體"], [{'text': '顔', 'reading': 'かお'}]),
        ("目", "め", "me", "眼睛", ["名詞", "身體"], [{'text': '目', 'reading': 'め'}]),
        ("耳", "みみ", "mimi", "耳朵", ["名詞", "身體"], [{'text': '耳', 'reading': 'みみ'}]),
        ("口", "くち", "kuchi", "嘴巴", ["名詞", "身體"], [{'text': '口', 'reading': 'くち'}]),
        ("歯", "は", "ha", "牙齒", ["名詞", "身體"], [{'text': '歯', 'reading': 'は'}]),
        ("手", "て", "te", "手", ["名詞", "身體"], [{'text': '手', 'reading': 'て'}]),
        ("足", "あし", "ashi", "腳", ["名詞", "身體"], [{'text': '足', 'reading': 'あし'}]),
        ("お腹", "おなか", "onaka", "肚子", ["名詞", "身體"], [{'text': 'お', 'reading': None}, {'text': '腹', 'reading': 'なか'}]),
        ("背", "せ", "se", "身高/背", ["名詞", "身體"], [{'text': '背', 'reading': 'せ'}]),
    ]
    for v in body:
        segs = v[5] if len(v) > 5 else None
        vocab_list.append(create_vocab(v[0], v[1], v[2], v[3], v[4], segs))

    # --- 13. 自然與天氣 (Nature & Weather) ---
    nature = [
        ("天気", "てんき", "tenki", "天氣", ["名詞", "自然"], [{'text': '天', 'reading': 'てん'}, {'text': '気', 'reading': 'き'}]),
        ("雨", "あめ", "ame", "雨", ["名詞", "自然"], [{'text': '雨', 'reading': 'あめ'}]),
        ("雪", "ゆき", "yuki", "雪", ["名詞", "自然"], [{'text': '雪', 'reading': 'ゆき'}]),
        ("曇り", "くもり", "kumori", "陰天", ["名詞", "自然"], [{'text': '曇', 'reading': 'くも'}, {'text': 'り', 'reading': None}]),
        ("晴れ", "はれ", "hare", "晴天", ["名詞", "自然"], [{'text': '晴', 'reading': 'は'}, {'text': 'れ', 'reading': None}]),
        ("風", "かぜ", "kaze", "風", ["名詞", "自然"], [{'text': '風', 'reading': 'かぜ'}]),
        ("空", "そら", "sora", "天空", ["名詞", "自然"], [{'text': '空', 'reading': 'そら'}]),
        ("花", "はな", "hana", "花", ["名詞", "自然"], [{'text': '花', 'reading': 'はな'}]),
        ("木", "き", "ki", "樹", ["名詞", "自然"], [{'text': '木', 'reading': 'き'}]),
        ("犬", "いぬ", "inu", "狗", ["名詞", "自然", "動物"], [{'text': '犬', 'reading': 'いぬ'}]),
        ("猫", "ねこ", "neko", "貓", ["名詞", "自然", "動物"], [{'text': '猫', 'reading': 'ねこ'}]),
        ("鳥", "とり", "tori", "鳥", ["名詞", "自然", "動物"], [{'text': '鳥', 'reading': 'とり'}]),
    ]
    for v in nature:
        segs = v[5] if len(v) > 5 else None
        vocab_list.append(create_vocab(v[0], v[1], v[2], v[3], v[4], segs))

    # --- 14. 衣物 (Clothing) ---
    clothing = [
        ("服", "ふく", "fuku", "衣服", ["名詞", "衣物"], [{'text': '服', 'reading': 'ふく'}]),
        ("シャツ", "シャツ", "shatsu", "襯衫", ["名詞", "衣物"]),
        ("コート", "コート", "kooto", "大衣", ["名詞", "衣物"]),
        ("セーター", "セーター", "seetaa", "毛衣", ["名詞", "衣物"]),
        ("スカート", "スカート", "sukaato", "裙子", ["名詞", "衣物"]),
        ("ズボン", "ズボン", "zubon", "褲子", ["名詞", "衣物"]),
        ("帽子", "ぼうし", "boushi", "帽子", ["名詞", "衣物"], [{'text': '帽', 'reading': 'ぼう'}, {'text': '子', 'reading': 'し'}]),
        ("ポケット", "ポケット", "poketto", "口袋", ["名詞", "衣物"]),
        ("ボタン", "ボタン", "botan", "鈕扣", ["名詞", "衣物"]),
    ]
    for v in clothing:
        segs = v[5] if len(v) > 5 else None
        vocab_list.append(create_vocab(v[0], v[1], v[2], v[3], v[4], segs))

    # --- 15. 副詞 (Adverbs) ---
    adverbs = [
        ("いつも", "いつも", "itsumo", "總是", ["副詞"]),
        ("たぶん", "たぶん", "tabun", "大概", ["副詞"]),
        ("とても", "とても", "totemo", "非常", ["副詞"]),
        ("よく", "よく", "yoku", "經常/很好地", ["副詞"]),
        ("大体", "だいたい", "daitai", "大體上", ["副詞"], [{'text': '大', 'reading': 'だい'}, {'text': '体', 'reading': 'たい'}]),
        ("少し", "すこし", "sukoshi", "一點點", ["副詞"], [{'text': '少', 'reading': 'すこ'}, {'text': 'し', 'reading': None}]),
        ("ちょっと", "ちょっと", "chotto", "稍微/一下", ["副詞"]),
        ("もう", "もう", "mou", "已經/再", ["副詞"]),
        ("まだ", "まだ", "mada", "還沒", ["副詞"]),
        ("もっと", "もっと", "motto", "更", ["副詞"]),
        ("また", "また", "mata", "又/再", ["副詞"]),
        ("ゆっくり", "ゆっくり", "yukkuri", "慢慢地", ["副詞"]),
        ("すぐ", "すぐ", "sugu", "馬上", ["副詞"]),
        ("初めて", "はじめて", "hajimete", "初次", ["副詞"], [{'text': '初', 'reading': 'はじ'}, {'text': 'めて', 'reading': None}]),
        ("一人で", "ひとりで", "hitoride", "一個人", ["副詞"], [{'text': '一', 'reading': 'ひと'}, {'text': '人で', 'reading': 'りで'}]),
    ]
    for v in adverbs:
        segs = v[5] if len(v) > 5 else None
        vocab_list.append(create_vocab(v[0], v[1], v[2], v[3], v[4], segs))

    # --- 16. 接續詞 (Conjunctions) ---
    conjunctions = [
        ("そして", "そして", "soshite", "然後", ["接續詞"]),
        ("それから", "それから", "sorekara", "還有/然後", ["接續詞"]),
        ("でも", "でも", "demo", "但是", ["接續詞"]),
        ("しかし", "しかし", "shikashi", "可是", ["接續詞"]),
        ("だから", "だから", "dakara", "所以", ["接續詞"]),
    ]
    for v in conjunctions:
         vocab_list.append(create_vocab(v[0], v[1], v[2], v[3], v[4]))

    # --- 17. 學習與學校 (School) ---
    school = [
        ("授業", "じゅぎょう", "jugyou", "上課", ["名詞", "學校"], [{'text': '授', 'reading': 'じゅ'}, {'text': '業', 'reading': 'ぎょう'}]),
        ("宿題", "しゅくだい", "shukudai", "作業", ["名詞", "學校"], [{'text': '宿', 'reading': 'しゅく'}, {'text': '題', 'reading': 'だい'}]),
        ("試験", "しけん", "shiken", "考試", ["名詞", "學校"], [{'text': '試', 'reading': 'し'}, {'text': '験', 'reading': 'けん'}]),
        ("テスト", "テスト", "tesuto", "測驗", ["名詞", "學校"]),
        ("問題", "もんだい", "mondai", "問題", ["名詞", "學校"], [{'text': '問', 'reading': 'もん'}, {'text': '題', 'reading': 'だい'}]),
        ("答え", "こたえ", "kotae", "答案", ["名詞", "學校"], [{'text': '答', 'reading': 'こた'}, {'text': 'え', 'reading': None}]),
        ("字", "じ", "ji", "字", ["名詞", "學校"], [{'text': '字', 'reading': 'じ'}]),
        ("漢字", "かんじ", "kanji", "漢字", ["名詞", "學校"], [{'text': '漢', 'reading': 'かん'}, {'text': '字', 'reading': 'じ'}]),
        ("作文", "さくぶん", "sakubun", "作文", ["名詞", "學校"], [{'text': '作', 'reading': 'さく'}, {'text': '文', 'reading': 'ぶん'}]),
        ("意味", "いみ", "imi", "意思", ["名詞", "學校"], [{'text': '意', 'reading': 'い'}, {'text': '味', 'reading': 'み'}]),
    ]
    for v in school:
        segs = v[5] if len(v) > 5 else None
        vocab_list.append(create_vocab(v[0], v[1], v[2], v[3], v[4], segs))

    # --- 18. 片假名外來語 (Katakana Loanwords) ---
    katakana = [
        ("アパート", "アパート", "apaato", "公寓", ["名詞", "場所"]),
        ("エレベーター", "エレベーター", "erebeetaa", "電梯", ["名詞", "場所"]),
        ("エスカレーター", "エスカレーター", "esukareetaa", "手扶梯", ["名詞", "場所"]),
        ("ホテル", "ホテル", "hoteru", "飯店", ["名詞", "場所"]),
        ("トイレ", "トイレ", "toire", "廁所", ["名詞", "場所"]),
        ("テレビ", "テレビ", "terebi", "電視", ["名詞", "日用品"]),
        ("ラジオ", "ラジオ", "rajio", "收音機", ["名詞", "日用品"]),
        ("カメラ", "カメラ", "kamera", "相機", ["名詞", "日用品"]),
        ("コンピューター", "コンピューター", "konpyuutaa", "電腦", ["名詞", "日用品"]),
        ("パソコン", "パソコン", "pasokon", "個人電腦", ["名詞", "日用品"]),
        ("インターネット", "インターネット", "intaanetto", "網際網路", ["名詞", "日用品"]),
        ("メール", "メール", "meeru", "郵件", ["名詞", "日用品"]),
        ("ニュース", "ニュース", "nyuusu", "新聞", ["名詞"]),
        ("プレゼント", "プレゼント", "purezento", "禮物", ["名詞", "日用品"]),
        ("パーティー", "パーティー", "paatii", "派對", ["名詞", "活動"]),
        ("スポーツ", "スポーツ", "supootsu", "運動", ["名詞", "活動"]),
        ("サッカー", "サッカー", "sakkaa", "足球", ["名詞", "活動"]),
        ("テニス", "テニス", "tenisu", "網球", ["名詞", "活動"]),
        ("バスケットボール", "バスケットボール", "basukettobooru", "籃球", ["名詞", "活動"]),
        ("プール", "プール", "puuru", "游泳池", ["名詞", "場所"]),
        ("ピアノ", "ピアノ", "piano", "鋼琴", ["名詞", "日用品"]),
        ("ギター", "ギター", "gitaa", "吉他", ["名詞", "日用品"]),
        ("コンサート", "コンサート", "konsaato", "音樂會", ["名詞", "活動"]),
        ("チケット", "チケット", "chiketto", "票", ["名詞", "日用品"]),
        ("パスポート", "パスポート", "pasupooto", "護照", ["名詞", "日用品"]),
        ("ベッド", "ベッド", "beddo", "床", ["名詞", "日用品"]),
        ("テーブル", "テーブル", "teeburu", "桌子", ["名詞", "日用品"]),
        ("ソファ", "ソファ", "sofa", "沙發", ["名詞", "日用品"]),
        ("ドア", "ドア", "doa", "門", ["名詞", "場所"]),
        ("カーテン", "カーテン", "kaaten", "窗簾", ["名詞", "日用品"]),
        ("シャワー", "シャワー", "shawaa", "淋浴", ["名詞", "日用品"]),
        ("エアコン", "エアコン", "eakon", "冷氣", ["名詞", "日用品"]),
        ("クラス", "クラス", "kurasu", "班級", ["名詞", "學校"]),
        ("ページ", "ページ", "peeji", "頁", ["名詞"]),
        ("テスト", "テスト", "tesuto", "考試", ["名詞", "學校"]),
        ("キロ", "キロ", "kiro", "公斤/公里", ["名詞", "單位"]),
        ("グラム", "グラム", "guramu", "公克", ["名詞", "單位"]),
        ("メートル", "メートル", "meetoru", "公尺", ["名詞", "單位"]),
    ]
    for v in katakana:
        vocab_list.append(create_vocab(v[0], v[1], v[2], v[3], v[4]))

    # --- 19. 動詞 Part 2 (Verbs II) ---
    verbs_2 = [
        ("開ける", "あける", "akeru", "打開 (他)", ["動詞", "二類動詞"], [{'text': '開', 'reading': 'あ'}, {'text': 'ける', 'reading': None}]),
        ("閉める", "しめる", "shimeru", "關閉 (他)", ["動詞", "二類動詞"], [{'text': '閉', 'reading': 'し'}, {'text': 'める', 'reading': None}]),
        ("開く", "あく", "aku", "開 (自)", ["動詞", "一類動詞"], [{'text': '開', 'reading': 'あ'}, {'text': 'く', 'reading': None}]),
        ("閉まる", "しまる", "shimaru", "關 (自)", ["動詞", "一類動詞"], [{'text': '閉', 'reading': 'し'}, {'text': 'まる', 'reading': None}]),
        ("つける", "つける", "tsukeru", "打開 (電器)", ["動詞", "二類動詞"]),
        ("消す", "けす", "kesu", "關掉 (電器)", ["動詞", "一類動詞"], [{'text': '消', 'reading': 'け'}, {'text': 'す', 'reading': None}]),
        ("立つ", "たつ", "tatsu", "站立", ["動詞", "一類動詞"], [{'text': '立', 'reading': 'た'}, {'text': 'つ', 'reading': None}]),
        ("座る", "すわる", "suwaru", "坐下", ["動詞", "一類動詞"], [{'text': '座', 'reading': 'すわ'}, {'text': 'る', 'reading': None}]),
        ("乗る", "のる", "noru", "搭乘", ["動詞", "一類動詞"], [{'text': '乗', 'reading': 'の'}, {'text': 'る', 'reading': None}]),
        ("降りる", "おりる", "oriru", "下車", ["動詞", "二類動詞"], [{'text': '降', 'reading': 'お'}, {'text': 'りる', 'reading': None}]),
        ("入る", "はいる", "hairu", "進入", ["動詞", "一類動詞"], [{'text': '入', 'reading': 'はい'}, {'text': 'る', 'reading': None}]),
        ("出る", "でる", "deru", "出去/離開", ["動詞", "二類動詞"], [{'text': '出', 'reading': 'で'}, {'text': 'る', 'reading': None}]),
        ("歩く", "あるく", "aruku", "走路", ["動詞", "一類動詞"], [{'text': '歩', 'reading': 'ある'}, {'text': 'く', 'reading': None}]),
        ("走る", "はしる", "hashiru", "跑步", ["動詞", "一類動詞"], [{'text': '走', 'reading': 'はし'}, {'text': 'る', 'reading': None}]),
        ("泳ぐ", "およぐ", "oyogu", "游泳", ["動詞", "一類動詞"], [{'text': '泳', 'reading': 'およ'}, {'text': 'ぐ', 'reading': None}]),
        ("遊ぶ", "あそぶ", "asobu", "玩耍", ["動詞", "一類動詞"], [{'text': '遊', 'reading': 'あそ'}, {'text': 'ぶ', 'reading': None}]),
        ("歌う", "うたう", "utau", "唱歌", ["動詞", "一類動詞"], [{'text': '歌', 'reading': 'うた'}, {'text': 'う', 'reading': None}]),
        ("旅行する", "りょこうする", "ryokousuru", "旅行", ["動詞", "三類動詞", "する動詞"], [{'text': '旅行', 'reading': 'りょこう'}, {'text': 'する', 'reading': None}]),
        ("買い物する", "かいものする", "kaimonosuru", "購物", ["動詞", "三類動詞", "する動詞"], [{'text': '買', 'reading': 'か'}, {'text': 'い', 'reading': None}, {'text': '物', 'reading': 'もの'}, {'text': 'する', 'reading': None}]),
        ("散歩する", "さんぽする", "sanposuru", "散步", ["動詞", "三類動詞", "する動詞"], [{'text': '散歩', 'reading': 'さんぽ'}, {'text': 'する', 'reading': None}]),
        ("練習する", "れんしゅうする", "renshuusuru", "練習", ["動詞", "三類動詞", "する動詞"], [{'text': '練習', 'reading': 'れんしゅう'}, {'text': 'する', 'reading': None}]),
        ("結婚する", "けっこんする", "kekkonsuru", "結婚", ["動詞", "三類動詞", "する動詞"], [{'text': '結婚', 'reading': 'けっこん'}, {'text': 'する', 'reading': None}]),
        ("撮る", "とる", "toru", "拍照", ["動詞", "一類動詞"], [{'text': '撮', 'reading': 'と'}, {'text': 'る', 'reading': None}]),
        ("吸う", "すう", "suu", "吸 (菸)", ["動詞", "一類動詞"], [{'text': '吸', 'reading': 'す'}, {'text': 'う', 'reading': None}]),
        ("言う", "いう", "iu", "說", ["動詞", "一類動詞"], [{'text': '言', 'reading': 'い'}, {'text': 'う', 'reading': None}]),
        ("覚える", "おぼえる", "oboeru", "記住", ["動詞", "二類動詞"], [{'text': '覚', 'reading': 'おぼ'}, {'text': 'える', 'reading': None}]),
        ("忘れる", "わすれる", "wasureru", "忘記", ["動詞", "二類動詞"], [{'text': '忘', 'reading': 'わす'}, {'text': 'れる', 'reading': None}]),
        ("知る", "しる", "shiru", "知道", ["動詞", "一類動詞"], [{'text': '知', 'reading': 'し'}, {'text': 'る', 'reading': None}]),
        ("わかる", "わかる", "wakaru", "懂/明白", ["動詞", "一類動詞"], [{'text': 'わか', 'reading': None}, {'text': 'る', 'reading': None}]),
        ("あげる", "あげる", "ageru", "給予", ["動詞", "二類動詞"]),
        ("もらう", "もらう", "morau", "收到", ["動詞", "一類動詞"]),
        ("くれる", "くれる", "kureru", "給我", ["動詞", "二類動詞"]),
        ("貸す", "かす", "kasu", "借出", ["動詞", "一類動詞"], [{'text': '貸', 'reading': 'か'}, {'text': 'す', 'reading': None}]),
        ("借りる", "かりる", "kariru", "借入", ["動詞", "二類動詞"], [{'text': '借', 'reading': 'か'}, {'text': 'りる', 'reading': None}]),
        ("返す", "かえす", "kaesu", "歸還", ["動詞", "一類動詞"], [{'text': '返', 'reading': 'かえ'}, {'text': 'す', 'reading': None}]),
        ("着る", "きる", "kiru", "穿 (上衣)", ["動詞", "二類動詞"], [{'text': '着', 'reading': 'き'}, {'text': 'る', 'reading': None}]),
        ("履く", "はく", "haku", "穿 (褲/鞋)", ["動詞", "一類動詞"], [{'text': '履', 'reading': 'は'}, {'text': 'く', 'reading': None}]),
        ("脱ぐ", "ぬぐ", "nugu", "脫", ["動詞", "一類動詞"], [{'text': '脱', 'reading': 'ぬ'}, {'text': 'ぐ', 'reading': None}]),
        ("被る", "かぶる", "kaburu", "戴 (帽)", ["動詞", "一類動詞"], [{'text': '被', 'reading': 'かぶ'}, {'text': 'る', 'reading': None}]),
        ("かける", "かける", "kakeru", "戴 (眼鏡)", ["動詞", "二類動詞"]),
        ("生まれる", "うまれる", "umareru", "出生", ["動詞", "二類動詞"], [{'text': '生', 'reading': 'う'}, {'text': 'まれる', 'reading': None}]),
        ("住む", "すむ", "sumu", "居住", ["動詞", "一類動詞"], [{'text': '住', 'reading': 'す'}, {'text': 'む', 'reading': None}]),
        ("勤める", "つとめる", "tsutomeru", "工作 (任職)", ["動詞", "二類動詞"], [{'text': '勤', 'reading': 'つと'}, {'text': 'める', 'reading': None}]),
    ]
    for v in verbs_2:
        segs = v[5] if len(v) > 5 else None
        vocab_list.append(create_vocab(v[0], v[1], v[2], v[3], v[4], segs))

    # --- 20. 量詞與時間生成的邏輯 (Programmatic Generation) ---
    # 人數
    people_counts = [
        ("一人", "ひとり", "hitori", "一個人"),
        ("二人", "ふたり", "futari", "兩個人"),
        ("三人", "さんにん", "sannin", "三個人"),
        ("四人", "よにん", "yonin", "四個人"),
        ("五人", "ごにん", "gonin", "五個人"),
        ("六人", "ろくにん", "rokunin", "六個人"),
        ("七人", "ななにん", "nananin", "七個人"),
        ("八人", "はちにん", "hachinin", "八個人"),
        ("九人", "きゅうにん", "kyuunin", "九個人"),
        ("十人", "じゅうにん", "juunin", "十個人"),
    ]
    for v in people_counts:
        # Simple segmentation logic for counters
        vocab_list.append(create_vocab(v[0], v[1], v[2], v[3], ["名詞", "數量詞"]))

    # 物品個數 (tsu)
    things_counts = [
        ("一つ", "ひとつ", "hitotsu", "一個"),
        ("二つ", "ふたつ", "futatsu", "兩個"),
        ("三つ", "みっつ", "mittsu", "三個"),
        ("四つ", "よっつ", "yottsu", "四個"),
        ("五つ", "いつつ", "itsutsu", "五個"),
        ("六つ", "むっつ", "muttsu", "六個"),
        ("七つ", "ななつ", "nanatsu", "七個"),
        ("八つ", "やっつ", "yattsu", "八個"),
        ("九つ", "ここのつ", "kokonotsu", "九個"),
        ("十", "とお", "tou", "十個"),
    ]
    for v in things_counts:
        vocab_list.append(create_vocab(v[0], v[1], v[2], v[3], ["名詞", "數量詞"]))

    # 本 (hon/bon/pon) - Long cylindrical objects
    hon_counts = [
        ("一本", "いっぽん", "ippon", "一根/瓶"),
        ("二本", "にほん", "nihon", "兩根/瓶"),
        ("三本", "さんぼん", "sanbon", "三根/瓶"),
        ("四本", "よんほん", "yonhon", "四根/瓶"),
        ("五本", "ごほん", "gohon", "五根/瓶"),
        ("六本", "ろっぽん", "roppon", "六根/瓶"),
        ("七本", "ななほん", "nanahon", "七根/瓶"),
        ("八本", "はっぽん", "happon", "八根/瓶"),
        ("九本", "きゅうほん", "kyuuhon", "九根/瓶"),
        ("十本", "じゅっぽん", "juppon", "十根/瓶"),
        ("何本", "なんぼん", "nanbon", "幾根/瓶"),
    ]
    for v in hon_counts:
        vocab_list.append(create_vocab(v[0], v[1], v[2], v[3], ["名詞", "數量詞"]))

   # 枚 (mai) - Flat objects
    mai_counts = [
        ("一枚", "いちまい", "ichimai", "一張"),
        ("二枚", "にまい", "nimai", "兩張"),
        ("三枚", "さんまい", "sanmai", "三張"),
        ("四枚", "よんまい", "yonmai", "四張"),
        ("五枚", "ごまい", "gomai", "五張"),
        ("九枚", "きゅうまい", "kyuumai", "九張"),
         ("何枚", "なんまい", "nanmai", "幾張"),
    ]
    for v in mai_counts:
        vocab_list.append(create_vocab(v[0], v[1], v[2], v[3], ["名詞", "數量詞"]))

    # 冊 (satsu) - Books
    satsu_counts = [
        ("一冊", "いっさつ", "issatsu", "一本 (書)"),
        ("二冊", "にさつ", "nisatsu", "兩本 (書)"),
        ("三冊", "さんさつ", "sansatsu", "三本 (書)"),
        ("八冊", "はっさつ", "hassatsu", "八本 (書)"),
        ("十冊", "じゅっさつ", "jussatsu", "十本 (書)"),
        ("何冊", "なんさつ", "nansatsu", "幾本 (書)"),
    ]
    for v in satsu_counts:
        vocab_list.append(create_vocab(v[0], v[1], v[2], v[3], ["名詞", "數量詞"]))

    # 時 (ji) - Time
    time_counts = [
        ("一時", "いちじ", "ichiji", "一點"),
        ("二時", "にじ", "niji", "兩點"),
        ("三時", "さんじ", "sanji", "三點"),
        ("四時", "よじ", "yoji", "四點"),
        ("五時", "ごじ", "goji", "五點"),
        ("六時", "ろくじ", "rokuji", "六點"),
        ("七時", "しちじ", "shichiji", "七點"),
        ("八時", "はちじ", "hachiji", "八點"),
        ("九時", "くじ", "kuji", "九點"),
        ("十時", "じゅうじ", "juuji", "十點"),
        ("十一時", "じゅういちじ", "juuichiji", "十一點"),
        ("十二時", "じゅうにじ", "juuniji", "十二點"),
    ]
    for v in time_counts:
        vocab_list.append(create_vocab(v[0], v[1], v[2], v[3], ["名詞", "時間"]))

    # 月 (gatsu) - Months
    month_counts = [
        ("一月", "いちがつ", "ichigatsu", "一月"),
        ("二月", "にがつ", "nigatsu", "二月"),
        ("三月", "さんがつ", "sangatsu", "三月"),
        ("四月", "しがつ", "shigatsu", "四月"),
        ("五月", "ごがつ", "gogatsu", "五月"),
        ("六月", "ろくがつ", "rokugatsu", "六月"),
        ("七月", "しちがつ", "shichigatsu", "七月"),
        ("八月", "はちがつ", "hachigatsu", "八月"),
        ("九月", "くがつ", "kugatsu", "九月"),
        ("十月", "じゅうがつ", "juugatsu", "十月"),
        ("十一月", "じゅういちがつ", "juuichigatsu", "十一月"),
        ("十二月", "じゅうにがつ", "juunigatsu", "十二月"),
    ]
    for v in month_counts:
        vocab_list.append(create_vocab(v[0], v[1], v[2], v[3], ["名詞", "時間"]))

    # 日 (nichi/ka) - Days (1st-10th, 14th, 20th, 24th are special)
    day_counts = [
        ("一日", "ついたち", "tsuitachi", "一號"),
        ("二日", "ふつか", "futsuka", "二號"),
        ("三日", "みっか", "mikka", "三號"),
        ("四日", "よっか", "yokka", "四號"),
        ("五日", "いつか", "itsuka", "五號"),
        ("六日", "むいか", "muika", "六號"),
        ("七日", "なのか", "nanoka", "七號"),
        ("八日", "ようか", "youka", "八號"),
        ("九日", "ここのか", "kokonoka", "九號"),
        ("十日", "とおか", "tooka", "十號"),
        ("十四日", "じゅうよっか", "juuyokka", "十四號"),
        ("二十日", "はつか", "hatsuka", "二十號"),
        ("二十四日", "にじゅうよっか", "nijuuyokka", "二十四號"),
    ]
    for v in day_counts:
        vocab_list.append(create_vocab(v[0], v[1], v[2], v[3], ["名詞", "時間"]))

    # --- 21. 數字與時間生成 (Programmatic: Numbers & Time) ---
    # Numbers 0-100
    base_nums = {
        0: ("ゼロ", "zero"), 1: ("一", "いち"), 2: ("二", "に"), 3: ("三", "さん"), 4: ("四", "よん"),
        5: ("五", "ご"), 6: ("六", "ろく"), 7: ("七", "なな"), 8: ("八", "はち"), 9: ("九", "きゅう"), 10: ("十", "じゅう")
    }
    
    for i in range(101):
        if i in base_nums:
            k, r = base_nums[i]
            vocab_list.append(create_vocab(str(i), k, "", f"數字 {i}", ["名詞", "數字"]))
            # Also add Kanji version
            vocab_list.append(create_vocab(k, k, "", f"數字 {i}", ["名詞", "數字"]))
        elif i < 20:
            ten = base_nums[10][0]
            digit = base_nums[i-10][0]
            text = ten + digit
            vocab_list.append(create_vocab(text, text, "", f"數字 {i}", ["名詞", "數字"]))
        else:
            tens = i // 10
            ones = i % 10
            text = base_nums[tens][0] + "十"
            if ones > 0:
                text += base_nums[ones][0]
            vocab_list.append(create_vocab(text, text, "", f"數字 {i}", ["名詞", "數字"]))

    # Minutes 1-60
    for i in range(1, 61):
        suffix = "分"
        reading_suffix = "ふん"
        if i % 10 in [1, 3, 4, 6, 8, 0]:
             reading_suffix = "ぷん"
        
        # Simplified generation for minutes (text only for bulk)
        vocab_list.append(create_vocab(f"{i}分", "", "", f"{i}分鐘", ["名詞", "時間"]))

    # Age 1-20
    for i in range(1, 21):
        vocab_list.append(create_vocab(f"{i}歳", "", "", f"{i}歲", ["名詞", "年齡"]))

    # --- 22. 國家 (Countries) ---
    countries = [
        ("アメリカ", "アメリカ", "amerika", "美國", ["名詞", "場所"]),
        ("イギリス", "イギリス", "igirisu", "英國", ["名詞", "場所"]),
        ("イタリア", "イタリア", "itaria", "義大利", ["名詞", "場所"]),
        ("イラン", "イラン", "iran", "伊朗", ["名詞", "場所"]),
        ("インド", "インド", "indo", "印度", ["名詞", "場所"]),
        ("インドネシア", "インドネシア", "indoneshia", "印尼", ["名詞", "場所"]),
        ("エジプト", "エジプト", "ejiputo", "埃及", ["名詞", "場所"]),
        ("オーストラリア", "オーストラリア", "oosutoraria", "澳洲", ["名詞", "場所"]),
        ("カナダ", "カナダ", "kanada", "加拿大", ["名詞", "場所"]),
        ("韓国", "かんこく", "kankoku", "韓國", ["名詞", "場所"]),
        ("タイ", "タイ", "tai", "泰國", ["名詞", "場所"]),
        ("中国", "ちゅうごく", "chuugoku", "中國", ["名詞", "場所"]),
        ("ドイツ", "ドイツ", "doitsu", "德國", ["名詞", "場所"]),
        ("日本", "にほん", "nihon", "日本", ["名詞", "場所"]),
        ("フランス", "フランス", "furansu", "法國", ["名詞", "場所"]),
        ("フィリピン", "フィリピン", "firipin", "菲律賓", ["名詞", "場所"]),
        ("ブラジル", "ブラジル", "burajiru", "巴西", ["名詞", "場所"]),
        ("ベトナム", "ベトナム", "betonamu", "越南", ["名詞", "場所"]),
        ("マレーシア", "マレーシア", "mareeshia", "馬來西亞", ["名詞", "場所"]),
        ("メキシコ", "メキシコ", "mekishiko", "墨西哥", ["名詞", "場所"]),
        ("ロシア", "ロシア", "roshia", "俄羅斯", ["名詞", "場所"]),
    ]
    for v in countries:
        vocab_list.append(create_vocab(v[0], v[1], v[2], v[3], v[4]))

    # --- 23. 擴充單字庫 (Final Boost) ---
    # 四季 (Seasons)
    seasons = [
        ("春", "はる", "haru", "春天", ["名詞", "自然", "季節"]),
        ("夏", "なつ", "natsu", "夏天", ["名詞", "自然", "季節"]),
        ("秋", "あき", "aki", "秋天", ["名詞", "自然", "季節"]),
        ("冬", "ふゆ", "fuyu", "冬天", ["名詞", "自然", "季節"]),
        ("季節", "きせつ", "kisetsu", "季節", ["名詞", "自然", "季節"]),
    ]
    for v in seasons: vocab_list.append(create_vocab(v[0], v[1], v[2], v[3], v[4]))

    # 動物 (Animals)
    animals = [
        ("動物", "どうぶつ", "doubutsu", "動物", ["名詞", "動物"]),
        ("馬", "うま", "uma", "馬", ["名詞", "動物"]),
        ("牛", "うし", "ushi", "牛", ["名詞", "動物"]),
        ("魚", "さかな", "sakana", "魚", ["名詞", "動物"]),
        ("象", "ぞう", "zou", "大象", ["名詞", "動物"]),
        ("豚", "ぶた", "buta", "豬", ["名詞", "動物"]),
        ("鼠", "ねずみ", "nezumi", "老鼠", ["名詞", "動物"]),
        ("猿", "さる", "saru", "猴子", ["名詞", "動物"]),
        ("羊", "ひつじ", "hitsuji", "綿羊", ["名詞", "動物"]),
        ("蛇", "へび", "hebi", "蛇", ["名詞", "動物"]),
        ("鶏", "にわとり", "niwatori", "雞", ["名詞", "動物"]),
    ]
    for v in animals: vocab_list.append(create_vocab(v[0], v[1], v[2], v[3], v[4]))
    
    # 顏色 (More Colors)
    colors = [
        ("色", "いろ", "iro", "顏色", ["名詞", "顏色"]),
        ("緑", "みどり", "midori", "綠色", ["名詞", "顏色"]),
        ("黄色", "きいろ", "kiiro", "黃色", ["名詞", "顏色"]),
        ("茶色", "ちゃいろ", "chairo", "茶色/棕色", ["名詞", "顏色"]),
        ("紫", "むらさき", "murasaki", "紫色", ["名詞", "顏色"]),
        ("オレンジ", "オレンジ", "orenji", "橘色", ["名詞", "顏色"]),
        ("ピンク", "ピンク", "pinku", "粉紅色", ["名詞", "顏色"]),
        ("グレー", "グレー", "guree", "灰色", ["名詞", "顏色"]),
    ]
    for v in colors: vocab_list.append(create_vocab(v[0], v[1], v[2], v[3], v[4]))

    # 家族 (Extended Family)
    family_ext = [
        ("家族", "かぞく", "kazoku", "家族/家人", ["名詞", "家庭"]),
        ("兄弟", "きょうだい", "kyoudai", "兄弟姊妹", ["名詞", "家庭"]),
        ("姉", "あね", "ane", "姊姊 (自稱)", ["名詞", "家庭"]),
        ("お姉さん", "おねえさん", "oneesan", "姊姊 (敬稱)", ["名詞", "家庭"]),
        ("妹", "いもうと", "imouto", "妹妹", ["名詞", "家庭"]),
        ("兄", "あに", "ani", "哥哥 (自稱)", ["名詞", "家庭"]),
        ("お兄さん", "おにいさん", "oniisan", "哥哥 (敬稱)", ["名詞", "家庭"]),
        ("弟", "おとうと", "otouto", "弟弟", ["名詞", "家庭"]),
        ("主人が", "しゅじん", "shujin", "丈夫 (自稱)", ["名詞", "家庭"]),
        ("夫", "おっと", "otto", "丈夫", ["名詞", "家庭"]),
        ("妻", "つま", "tsuma", "妻子", ["名詞", "家庭"]),
        ("家内", "かない", "kanai", "妻子 (自稱)", ["名詞", "家庭"]),
        ("奥さん", "おくさん", "okusan", "妻子 (敬稱)", ["名詞", "家庭"]),
        ("祖父", "そふ", "sofu", "祖父", ["名詞", "家庭"]),
        ("おじいさん", "おじいさん", "ojiisan", "老爺爺/祖父", ["名詞", "家庭"]),
        ("祖母", "そぼ", "sobo", "祖母", ["名詞", "家庭"]),
        ("おばあさん", "おばあさん", "obaasan", "老奶奶/祖母", ["名詞", "家庭"]),
        ("おじ", "おじ", "oji", "叔叔/伯父 (自稱)", ["名詞", "家庭"]),
        ("おじさん", "おじさん", "ojisan", "叔叔/伯父", ["名詞", "家庭"]),
        ("おば", "おば", "oba", "阿姨/嬸嬸 (自稱)", ["名詞", "家庭"]),
        ("おばさん", "おばさん", "obasan", "阿姨/嬸嬸", ["名詞", "家庭"]),
        ("両親", "りょうしん", "ryoushin", "雙親", ["名詞", "家庭"]),
        ("ご両親", "ごりょうしん", "goryoushin", "雙親 (敬稱)", ["名詞", "家庭"]),
    ]
    for v in family_ext: vocab_list.append(create_vocab(v[0], v[1], v[2], v[3], v[4]))

    # 形容詞 (More Adjectives - Opposites)
    adj_more = [
        ("重い", "おもい", "omoi", "重的", ["い形容詞"]),
        ("軽い", "かるい", "karui", "輕的", ["い形容詞"]),
        ("広い", "ひろい", "hiroi", "寬廣的", ["い形容詞"]),
        ("狭い", "せまい", "semai", "狹窄的", ["い形容詞"]),
        ("強い", "つよい", "tsuyoi", "強的", ["い形容詞"]),
        ("弱い", "よわい", "yowai", "弱的", ["い形容詞"]),
        ("暗い", "くらい", "kurai", "暗的", ["い形容詞"]),
        ("明るい", "あかるい", "akarui", "明亮的", ["い形容詞"]),
        ("甘い", "あまい", "amai", "甜的", ["い形容詞"]),
        ("辛い", "からい", "karai", "辣的/鹹的", ["い形容詞"]),
        ("早い", "はやい", "hayai", "早的 (時間)", ["い形容詞"]),
        ("速い", "はやい", "hayai", "快的 (速度)", ["い形容詞"]),
        ("遅い", "おそい", "osoi", "慢的/晚的", ["い形容詞"]),
        ("短い", "みじかい", "mijikai", "短的", ["い形容詞"]),
        ("長い", "ながい", "nagai", "長的", ["い形容詞"]),
        ("太い", "ふとい", "futoi", "粗的", ["い形容詞"]),
        ("細い", "ほそい", "hosoi", "細的", ["い形容詞"]),
        ("丸い", "まるい", "marui", "圓的", ["い形容詞"]),
        ("若いい", "わかい", "wakai", "年輕的", ["い形容詞"]),
        ("痛い", "いたい", "itai", "痛的", ["い形容詞"]),
    ]
    for v in adj_more: vocab_list.append(create_vocab(v[0], v[1], v[2], v[3], v[4]))

    # 學校科目與職業 (Subjects & Occupations)
    subjects = [
        ("英語", "えいご", "eigo", "英語", ["名詞", "學校", "語言"]),
        ("数学", "すうがく", "suugaku", "數學", ["名詞", "學校"]),
        ("科学", "かがく", "kagaku", "科學", ["名詞", "學校"]),
        ("歴史", "れきし", "rekishi", "歷史", ["名詞", "學校"]),
        ("地理", "ちり", "chiri", "地理", ["名詞", "學校"]),
        ("医者", "いしゃ", "isha", "醫生", ["名詞", "職業"]),
        ("看護婦", "かんごふ", "kangofu", "護士", ["名詞", "職業"]),
        ("エンジニア", "エンジニア", "enjinia", "工程師", ["名詞", "職業"]),
        ("主婦", "しゅふ", "shufu", "家庭主婦", ["名詞", "職業"]),
        ("会社員", "かいしゃいん", "kaishain", "公司職員", ["名詞", "職業"]),
        ("公務員", "こうむいん", "koumuin", "公務員", ["名詞", "職業"]),
        ("駅員", "えきいん", "ekiin", "車站人員", ["名詞", "職業"]),
        ("警察官", "けいさつかん", "keisatsukan", "警察", ["名詞", "職業"]),
        ("歌手", "かしゅ", "kashu", "歌手", ["名詞", "職業"]),
        ("運転手", "うんてんしゅ", "untenshu", "司機", ["名詞", "職業"]),
    ]
    for v in subjects: vocab_list.append(create_vocab(v[0], v[1], v[2], v[3], v[4]))

    # 日 (More Days 1-31 Programmatic)
    special_days = {
        1: ("ついたち", "tsuitachi"), 2: ("ふつか", "futsuka"), 3: ("みっか", "mikka"),
        4: ("よっか", "yokka"), 5: ("いつか", "itsuka"), 6: ("むいか", "muika"),
        7: ("なのか", "nanoka"), 8: ("ようか", "youka"), 9: ("ここのか", "kokonoka"),
        10: ("とおか", "tooka"), 14: ("じゅうよっか", "juuyokka"), 20: ("はつか", "hatsuka"),
        24: ("にじゅうよっか", "nijuuyokka")
    }
    
    for i in range(1, 41): # Up to 40 roughly to simulate "many days" or just 1-31
        if i > 31: break
        
        # Check if already added? Our previous list had special days.
        # We can add a "duplicate check" in `create_vocab` if we wanted, but here we just append.
        # To avoid clutter, let's just add the non-special ones primarily, or all.
        # Adding all ensures we have full list.
        
        if i in special_days:
            k, r = special_days[i]
            day_kanji = {1:"一日", 2:"二日", 3:"三日", 4:"四日", 5:"五日", 6:"六日", 7:"七日", 8:"八日", 9:"九日", 10:"十日", 14:"十四日", 20:"二十日", 24:"二十四日"}
            text = day_kanji.get(i, f"{i}日")
            # vocab_list.append(create_vocab(text, k, r, f"{i}號", ["名詞", "時間"])) # Skipping to avoid dupes with manual list if we keep it.
        else:
            # Regular reading: number + nichi
            num_kanji_map = {11:"十一", 12:"十二", 13:"十三", 15:"十五", 16:"十六", 17:"十七", 18:"十八", 19:"十九", 21:"二十一", 22:"二十二", 23:"二十三", 25:"二十五", 26:"二十六", 27:"二十七", 28:"二十八", 29:"二十九", 30:"三十", 31:"三十一"}
            if i in num_kanji_map:
                 text = num_kanji_map[i] + "日"
                 reading = "" # Simplified
                 vocab_list.append(create_vocab(text, text, reading, f"{i}號", ["名詞", "時間"]))

    # --- 26. 水果與蔬菜 (Fruits & Vegetables) ---
    fruits_veg = [
        ("果物", "くだもの", "kudamono", "水果", ["名詞", "食物"]),
        ("野菜", "やさい", "yasai", "蔬菜", ["名詞", "食物"]),
        ("りんご", "りんご", "ringo", "蘋果", ["名詞", "食物"]),
        ("バナナ", "バナナ", "banana", "香蕉", ["名詞", "食物"]),
        ("みかん", "みかん", "mikan", "橘子", ["名詞", "食物"]),
        ("ぶどう", "ぶどう", "budou", "葡萄", ["名詞", "食物"]),
        ("いちご", "いちご", "ichigo", "草莓", ["名詞", "食物"]),
        ("すいか", "すいか", "suika", "西瓜", ["名詞", "食物"]),
        ("トマト", "トマト", "tomato", "番茄", ["名詞", "食物"]),
        ("じゃがいも", "じゃがいも", "jagaimo", "馬鈴薯", ["名詞", "食物"]),
        ("にんじん", "にんじん", "ninjin", "胡蘿蔔", ["名詞", "食物"]),
        ("玉ねぎ", "たまねぎ", "tamanegi", "洋蔥", ["名詞", "食物"]),
        ("きゅうり", "きゅうり", "kyuuri", "小黃瓜", ["名詞", "食物"]),
        ("キャベツ", "キャベツ", "kyabetsu", "高麗菜", ["名詞", "食物"]),
        ("とんかつ", "とんかつ", "tonkatsu", "炸豬排", ["名詞", "食物"]),
        ("カレー", "カレー", "karee", "咖哩", ["名詞", "食物"]),
        ("ラーメン", "ラーメン", "raamen", "拉麵", ["名詞", "食物"]),
        ("うどん", "うどん", "udon", "烏龍麵", ["名詞", "食物"]),
        ("そば", "そば", "soba", "蕎麥麵", ["名詞", "食物"]),
        ("ハンバーガー", "ハンバーガー", "hanbaagaa", "漢堡", ["名詞", "食物"]),
    ]
    for v in fruits_veg: vocab_list.append(create_vocab(v[0], v[1], v[2], v[3], v[4]))

    # --- 27. 其他 (Others) ---
    others = [
        ("はい", "はい", "hai", "是", ["感嘆詞"]),
        ("いいえ", "いいえ", "iie", "不是", ["感嘆詞"]),
        ("これ", "これ", "kore", "這個", ["代名詞"]),
    ]
    for v in others:
         vocab_list.append(create_vocab(v[0], v[1], v[2], v[3], v[4]))

    # Output to JSON file
    output_path = 'assets/data/vocabulary_n5.json'
    with open(output_path, 'w', encoding='utf-8') as f:
        json.dump(vocab_list, f, ensure_ascii=False, indent=4)

    print(f"Generated {len(vocab_list)} vocabularies to {output_path}")

if __name__ == "__main__":
    main()
