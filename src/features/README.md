## /features 戦略

コンポーネントに直接 useQuery を書くのではなく、「機能ごとのカスタムフック」 を一枚挟むアーキテクチャにします。これだけで、UIコードはバックエンドを一切意識せずに済みます。

### 推奨ディレクトリ構造

```
src/
  features/
    todo/
      components/
        TodoList.tsx       <-- ここは絶対に変更しない
      api/
        use-todos.ts       <-- ★ここだけ差し替える
```
