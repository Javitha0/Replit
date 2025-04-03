import { Suspense, lazy } from "react";
import { ErrorBoundary } from "react-error-boundary";
import { Switch, Route } from "wouter";
import { QueryClientProvider } from "@tanstack/react-query";
import { Toaster } from "@/components/ui/toaster";
import { ThemeProvider } from "@/hooks/use-theme";
import { queryClient } from "./lib/queryClient";
import LoadingScreen from "@/components/LoadingScreen";
import ErrorScreen from "@/components/ErrorScreen";
import CookieConsent from "@/components/CookieConsent";

// Lazy load pages
const Home = lazy(() => import("@/pages/Home"));
const NotFound = lazy(() => import("@/pages/not-found"));

function Router() {
  return (
    <Suspense fallback={<LoadingScreen />}>
      <Switch>
        <Route path="/" component={Home} />
        <Route component={NotFound} />
      </Switch>
    </Suspense>
  );
}

function App() {
  return (
    <ErrorBoundary
      FallbackComponent={ErrorScreen}
      onError={(error) => console.error("App Error:", error)}
    >
      <ThemeProvider>
        <QueryClientProvider client={queryClient}>
          <Router />
          <Toaster />
          <CookieConsent />
        </QueryClientProvider>
      </ThemeProvider>
    </ErrorBoundary>
  );
}

export default App;