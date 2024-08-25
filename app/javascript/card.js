// 現在のページが「/items/数値/purchases」に一致する場合にのみ処理を実行
if (location.pathname.match(/items\/\d{1,5}\/purchases/)) {

  // 支払い処理を行う関数を定義
  const pay = () => {
    // サーバー側から提供される公開キーを取得
    const publicKey = gon.public_key;

    // PAY.JPのインスタンスを公開キーを使って作成
    const payjp = Payjp(publicKey);

    // 支払いに使用するカード情報の入力要素を作成するためのelementsを作成
    const elements = payjp.elements();

    // カード番号、期限、CVCの入力フィールドを作成
    const numberElement = elements.create('cardNumber');
    const expiryElement = elements.create('cardExpiry');
    const cvcElement = elements.create('cardCvc');

    // 各入力フィールドを指定したHTML要素にマウント（DOMに挿入）
    numberElement.mount('#number-form');
    expiryElement.mount('#expiry-form');
    cvcElement.mount('#cvc-form');

    // フォーム要素を取得
    const form = document.getElementById('charge-form');

    // フォームの送信イベントを監視し、送信時に処理を実行
    form.addEventListener("submit", (e) => {
      // カード番号入力要素からトークンを生成
      payjp.createToken(numberElement).then(function (response) {

        // トークン生成時にエラーが発生したかを確認
        if (response.error) {
          // エラーが発生した場合、特に処理はない（エラーメッセージの表示などが可能）
        } else {
          // トークンの取得に成功した場合
          const token = response.id; // トークンIDを取得

          // フォーム要素に新しい隠しフィールドとしてトークンを追加
          const renderDom = document.getElementById("charge-form");
          const tokenObj = `<input value=${token} name='token' type="hidden">`;
          renderDom.insertAdjacentHTML("beforeend", tokenObj); // トークンをフォームに埋め込む
        }

        // 入力フィールドの内容をクリア（セキュリティのため）
        numberElement.clear();
        expiryElement.clear();
        cvcElement.clear();

        // フォームを再送信して、サーバーにデータを送る
        document.getElementById("charge-form").submit();
      });

      // フォームのデフォルトの送信動作をキャンセルしてトークン生成を優先
      e.preventDefault();
    });
  };

  // Turboフレームワークのロード時にpay関数を呼び出す
  window.addEventListener("turbo:load", pay);

  // Turboのレンダリングイベント時にpay関数を呼び出す
  window.addEventListener("turbo:render", pay);
}
