import MainContent from "./components/MainContent";
import logo from "./assets/images/logo.png";

function App() {
  // Simulate user-controlled input from the URL
  const params = new URLSearchParams(window.location.search);
  const unsafeContent = params.get("msg") || "Hello from safe default";

  return (
    <>
      <header>
        <div id="logo-img">
          <img src={logo} />
        </div>
        <h1>cristi-branch: small change</h1>
      </header>

      {/* INTENTIONALLY UNSAFE: user-controlled HTML */}
      <div
        id="unsafe-block"
        dangerouslySetInnerHTML={{ __html: unsafeContent }}
      />

      <MainContent />
    </>
  );
}

export default App;
