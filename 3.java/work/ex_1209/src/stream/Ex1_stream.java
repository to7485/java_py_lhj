package stream;

import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.Set;
import java.util.function.Predicate;
import java.util.stream.Collectors;
import java.util.stream.Stream;

public class Ex1_stream {
	public static void main(String[] args) {
		List<String> names = List.of("철수","영희","민수");
		
		//스트림의 생성
		Stream<String> s_names = names.stream();
		
		//forEach() - 각 요소에 대해 작업을 수행하는 최종 연산
		
		//중간연산(내가 원하는 걸로 가공)
		List<Integer> nums = List.of(5,1,4,2,3,6,9,8,7,6,6,5,5,3,2,1,1,1);
		
		//filter - 조건에 맞는 것만 남기는 중간연산
		
		nums.stream()
			.filter(x -> x % 2 == 0)//짝수만
			.forEach(System.out::println);
		
		//map - 요소에 처리를 해주는 중간 연산
		names.stream()
			.map(x -> x + "님")
			.forEach(System.out::println);
		
		//sotred - 정렬 (오름차순)
		nums.stream()
			.sorted()
			.forEach(System.out::println);
		System.out.println("------------------------");
		//내림차순
		nums.stream()
			.sorted((a,b) -> b-a)
			.forEach(System.out::println);
		System.out.println("------------------------");
		//distinct - 중복제거
		nums.stream()
			.distinct()
			.sorted()
			.forEach(System.out::println);
		
		System.out.println("------------------------");
		//limit/skip - 일부만 잘라 쓰는 중간 연산
		nums.stream()
			.limit(3) //앞에서부터 3개만
			.forEach(System.out::println);
		
		System.out.println("------------------------");
		nums.stream()
			.skip(3) //앞의 3개를 자르고 나머지를 출력
			.forEach(System.out::println);
		
		//스트림으로 가공한 결과를 List, Set같은 컬렉션으로 다시 만들고싶으면
		//Collection(Collectors...)를 사용한다.
		
		List<Integer> evenList = nums.stream()
									.filter(x -> x % 2 == 0)
									.distinct()
									.sorted()
									.collect(Collectors.toList());//결과를 List로 만들어서 반환
		
		//Collectors에 들어있는 메서드
		//toList() : 리스트로 반환
		//toSet() : set으로 반환
		//joining(", ") : 문자열들을 하나로 합치기
		//groupingBy(...) : 특정 기준으로 그룹 나누기
		
		List<String> items = List.of("A","B","A","C");
		
		Set<String> set = items.stream()
							.collect(Collectors.toSet());
		
		System.out.println(set);
		
		List<String> words = List.of("Java","Spring","React");
		
		String joined = words.stream()
							.collect(Collectors.joining(", "));
		
		System.out.println(joined);
		
		List<String> names2 = List.of("Kim","Lee","Park","Choi","Jin");
		
		Map<Integer, List<String>> grouped = 
				names2.stream()
					.collect(Collectors.groupingBy(name -> name.length()));
		
		System.out.println(grouped);
		
		//count - 개수 세기
		long count = nums.stream()
						.filter(x -> x % 2 == 0)
						.count();
		
		System.out.println("짝수의 개수 : " + count);
		
		int count2 = 0;
		for(Integer x : nums) {
			if( x % 2 == 0) {
				count2++;
			}
		}
		
		System.out.println("짝수의 개수 : " + count2);
		
		//조건 만족 여부 검사
		List<Integer> nums2 = List.of(1,2,3,4,5);
		//결과를 boolean으로 반환
		//anyMatch - 하나라도 만족하면 true을 반환
		boolean hasEven = nums2.stream().anyMatch(x -> x % 2 == 0);
		
		System.out.println("hasEven : " + hasEven);
		
		//allMatch - 요소들이 모두 조건을 만족하는가
		boolean allPositive = nums2.stream().allMatch(x -> x > 0);
		
		System.out.println("allPositive : " + allPositive);
		
		//noneMatch - 요소들이 모두 조건을 만족하지 않으면 참
		boolean noneNegative = nums2.stream().noneMatch(x -> x < 0);
		
		System.out.println("noneNegative : " + noneNegative);
		
		//하나만 찾기
		//findFirst
		Optional<String> result = names.stream()
									.filter(s -> s.startsWith("영"))
									.findFirst();
		
		result.ifPresent(System.out::println);
		
		//findAny - 스트림 요소에서 아무거나 반환
		Optional<String> anyName = names.stream()
									.filter(x -> x.length() == 2)
									.findAny();
		
		anyName.ifPresent(System.out::println);
		//무엇이 나올지는 보장이 안된다.
		
		//reduce - 값을 누적시킨다.
		int sum = nums.stream()
					.reduce(0, (acc,n) -> acc + n);
		
		
		
		
		
		
		
		
		
		
		
		
		
		
	}
}
